# frozen_string_literal: true

class SearchService < BaseService
  attr_reader :search_value

  def initialize(opts = {})
    super
    @search_value = opts[:search_value]
  end

  def call
    return searched_word.related_words if valid?

    words_from_api
  end

  private

    def words_from_api
      @words_from_api ||= SearchWordsFromApiService.call(
        search_value: search_value
      )
    end

    def valid?
      searched_word.present? && searched_word.related_words.count > 3
    end

    # * Returns first word (most valuble) from db
    def searched_word
      # TODO: To be changed for searchkiq method.
      @searched_word ||= Word.where(value: search_value).first
    end
end
