# frozen_string_literal: true

class SearchWordsFromApiService < BaseService
  attr_reader :search_value, :client, :adapter

  def initialize(opts = {})
    super
    @search_value = opts[:search_value]
    @client = Datamuse::Words
    @adapter = Datamuse::Adapters::WordAdapter
  end

  def call
    return [] if results.blank?

    store_searched_value
    store_related_words

    store_searched_value.related_words
  end

  private

    def store_searched_value
      @store_searched_value ||= Word.find_or_create_by(value: search_value)
    end

    def store_related_words
      store_searched_value.related_words.create(valid_data)
    end

    def valid_data
      parsed_data.filter do |record|
        word = Word.new(record)
        word.valid?
      end
    end

    def parsed_data
      @parsed_data ||= adapter.parse(results)
    end

    def results
      @results ||= client.search(params: { ml: search_value })
    end
end
