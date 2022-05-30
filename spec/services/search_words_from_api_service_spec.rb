# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchWordsFromApiService, :vcr, type: :service do
  subject { described_class }

  context 'when api response returns records' do
    let(:search_value) { 'kitchen' }

    it 'store searched value' do
      expect { subject.call(search_value: search_value) }.to(change { Word.count })
      expect(Word.find_by(value: search_value)).to be_present
    end

    it 'store results as searched_value related_words' do
      expect { subject.call(search_value: search_value) }
        .to change { Word.count }
        .and(change { WordAssociation.count })
    end

    it 'returns searched_value related_words array' do
      expect(subject.call(search_value: search_value)).to eq(Word.find_by(value: search_value).related_words)
    end
  end

  context 'when api response does not have records' do
    let(:search_value) { 'foo-bar' }

    it 'returns an empty array' do
      expect(subject.call(search_value: search_value)).to eq([])
    end

    it 'does not store search word' do
      expect { subject.call(search_value: search_value) }.not_to(change { Word.count })
    end
  end
end
