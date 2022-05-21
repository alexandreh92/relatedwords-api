# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request::Base, type: :lib do
  subject(:lib) { described_class.new }

  let(:body) { { id: 1 }.to_json }
  let(:response) { double('response', status: 200, body: body) }

  context '#connection' do
    subject { lib.send(:connection) }

    it 'returns a faraday connection' do
      expect(subject).to be_a(Faraday::Connection)
    end

    it 'returns the pre-configured connection with custom middleware' do
      handlers = subject.builder.handlers
      expect(handlers).to include(Request::ExceptionMiddleware)
    end
  end

  context '#get' do
    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(response)
    end

    it 'returns value from get method' do
      expect(described_class.new.get('testing')).to eq(JSON.parse(body, symbolize_names: true))
    end
  end

  context 'when failures occurs' do
    subject { lib.get('testing') }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(response)
    end

    context 'when JSON.parse fails' do
      before do
        allow(JSON).to receive(:parse).and_raise(TypeError)
      end

      it 're-raise Request::Exceptions::ParseException error' do
        expect { subject }.to raise_error(Request::Exceptions::ParseException)
      end
    end

    context 'when generic error occurs' do
      before do
        allow(JSON).to receive(:parse).and_raise(StandardError)
      end

      it 're-raise Exceptions::RequestException ' do
        expect { subject }.to raise_error(Request::Exceptions::RequestException)
      end
    end
  end
end
