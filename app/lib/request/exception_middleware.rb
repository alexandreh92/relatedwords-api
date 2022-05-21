# frozen_string_literal: true

module Request
  class ExceptionMiddleware < Faraday::Middleware
    def call(env)
      response = @app.call(env)

      return response if [200, 201, 202].include?(response.status)

      handle_exceptions(response)
    end

    private

      def handle_exceptions(response)
        # raise errors for http statuses
      end
  end
end
