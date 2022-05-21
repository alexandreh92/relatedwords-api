# frozen_string_literal: true

module Datamuse
  class Words < Base
    def self.search(opts = {})
      new.get('words') do |request|
        request.params = opts[:params]
      end
    end
  end
end
