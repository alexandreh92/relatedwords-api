# frozen_string_literal: true

module Request
  module Exceptions
    class RequestException < StandardError
      def initialize(message, request = nil, host = nil)
        @request = request
        @host = host
        super(message)
      end
    end
  end
end
