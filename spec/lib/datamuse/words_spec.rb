require 'rails_helper'

RSpec.describe Datamuse::Words, :vcr, type: :lib do
  describe '#search' do
    let(:params) { { ml: 'kitchen' } }

    subject { described_class.search(params: params) }

    it 'calls api and return data' do
      expect(subject.first).to include_json(
        word: be_kind_of(String),
        score: be_kind_of(Integer),
        tags: be_kind_of(Array)
      )
    end
  end
end
