# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Datamuse::Words, :vcr, type: :lib do
  describe '#search' do
    let(:faraday_connection) { instance_spy Faraday::Connection }
    let(:faraday_request) { instance_spy Faraday::Request }
    let(:params) { { ml: 'kitchen' } }
    let(:url) { 'https://api.datamuse.com' }
    let(:path) { 'words' }
    let(:response) { double :response, body: '[{"success": true}]' }

    subject { described_class.search(params: params) }

    it 'calls connection with words path' do
      allow(Faraday).to receive(:new).with(url: url).and_return(faraday_connection)
      allow(faraday_connection).to receive(:get).and_yield(faraday_request).and_return(response)

      subject
      expect(faraday_connection).to have_received(:get).with(path)
    end

    it 'calls api and return data' do
      expect(subject.first).to include_json(
        word: be_kind_of(String),
        score: be_kind_of(Integer),
        tags: be_kind_of(Array)
      )
    end
  end
end
