# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Datamuse::Base, type: :lib do
  subject(:lib) { described_class.new }

  let(:faraday_connection) { instance_spy Faraday::Connection }
  let(:faraday_request) { instance_spy Faraday::Request }
  let(:url) { 'https://api.datamuse.com' }
  let(:path) { 'foo' }
  let(:params) { { ml: 'kitchen' } }
  let(:response) { instance_double(Faraday::Response, :response, body: '[{"success": true}]') }

  before do
    allow(Faraday).to receive(:new).with(url: url).and_return(faraday_connection)
    allow(faraday_connection).to receive(:get).and_yield(faraday_request).and_return(response)
  end

  it 'calls request base with base url' do
    lib.get('foo') { |req| req.params = params }
    expect(faraday_connection).to have_received(:get).with(path)
  end
end
