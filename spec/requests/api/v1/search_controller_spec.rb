# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/search', type: :request do
  path '/api/v1/search' do
    describe 'GET#index' do
      get 'Returns related words' do
        tags 'Search'
        consumes 'application/json'
        parameter name: :value, in: :query, type: :string, required: true

        let(:value) { 'kitchen' }

        context 'with success' do
          let!(:word) { create(:word, :with_related_words, value: value) }

          before do
            allow_any_instance_of(SearchService).to receive(:call).and_return(word.related_words)
          end

          response '200', 'successful' do
            run_test! do |response|
              parsed_body = JSON.parse(response.body, symbolize_names: true)

              expect(parsed_body).to include_json(
                {
                  collection: be_kind_of(Array),
                  page: be_kind_of(Integer),
                  per_page: be_kind_of(Integer),
                  total_entries: be_kind_of(Integer),
                  total_pages: be_kind_of(Integer)
                }
              )

              expect(parsed_body[:collection]).to contain_exactly(
                a_hash_including(id: word.related_words.first.id),
                a_hash_including(id: word.related_words.second.id),
                a_hash_including(id: word.related_words.third.id),
                a_hash_including(id: word.related_words.fourth.id)
              )
            end
          end
        end
      end
    end
  end
end
