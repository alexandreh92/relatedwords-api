# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Datamuse::Base, type: :lib do
  let(:faraday_connection) { instance_spy Faraday::Connection }
  let(:faraday_request) { instance_spy Faraday::Request }
  let(:url) { 'https://api.datamuse.com' }
  let(:path) { 'foo' }
  let(:params) { { ml: 'kitchen' } }
  let(:response) { double :response, body: '[{"success": true}]' }

  before do
    allow(Faraday).to receive(:new).with(url: url).and_return(faraday_connection)
    allow(faraday_connection).to receive(:get).and_yield(faraday_request).and_return(response)
  end

  subject { described_class.new.get('foo') { |req| req.params = params } }

  it 'calls request base with base url' do
    subject
    expect(faraday_connection).to have_received(:get).with(path)
  end
end
