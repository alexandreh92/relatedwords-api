# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService, type: :service do
  subject(:service) { described_class }

  let(:search_value) { 'kitchen' }

  shared_examples 'calls search from api' do
    let(:search_from_api_mock) { double }
    let(:search_from_api_response) { build_list(:word, 2) }

    before do
      allow(SearchWordsFromApiService).to receive(:new)
        .with(search_value: search_value).and_return(search_from_api_mock)
      allow(search_from_api_mock).to receive(:call).and_return(search_from_api_response)
    end

    it 'creates a new search from api instance' do
      subject.call(search_value: search_value)
      expect(SearchWordsFromApiService).to have_received(:new).with(search_value: search_value)
    end

    it 'calls search from api' do
      subject.call(search_value: search_value)
      expect(search_from_api_mock).to have_received(:call)
    end

    it 'returns search from api response' do
      expect(subject.call(search_value: search_value)).to eq(search_from_api_response)
    end
  end

  context 'when searched word is persisted on db' do
    context 'when its related words are greater than 3' do
      let!(:word) { create(:word, :with_related_words, value: search_value) }

      it 'returns persisted related words' do
        expect(service.call(search_value: search_value)).to eq(word.related_words)
      end
    end

    context 'when its related words are lesser or eq than 3' do
      # rubocop:disable RSpec/LetSetup
      let!(:word) { create(:word, value: search_value, related_words: build_list(:word, 3)) }
      # rubocop:enable RSpec/LetSetup

      it_behaves_like 'calls search from api'
    end
  end

  context 'when searched word is not persisted on db' do
    it_behaves_like 'calls search from api'
  end
end
