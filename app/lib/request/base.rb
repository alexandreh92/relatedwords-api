# frozen_string_literal: true

module Request
  class ParseError < StandardError
    def initialize(response)
      @response = response.body
      super(@response)
    end
  end

  class Base
    DEFAULT_BASE_URL = '/'

    attr_reader :base_url, :response

    def initialize(opts = {})
      @base_url = opts[:base_url] || DEFAULT_BASE_URL
      @response = nil
    end

    def get(path, &block)
      @response = connection.send(__method__, path, &block)
      with_rescue do
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    private

      def connection
        @connection ||= Faraday.new(base_url) do |f|
          f.use ExceptionMiddleware
          f.request :retry,
                    max: 2,
                    interval: 0.05,
                    interval_randomness: 0.5,
                    backoff_factor: 2
        end
      end

      def with_rescue
        yield
      rescue TypeError => e
        raise Exceptions::ParseException, e.to_s
      rescue StandardError => e
        raise RequestException.new(e, response, base_url)
      end
  end
end
