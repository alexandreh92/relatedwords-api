# frozen_string_literal: true

module Datamuse
  class Base < Request::Base
    DEFAULT_BASE_URL = 'https://api.datamuse.com'

    def initialize
      super(base_url: DEFAULT_BASE_URL)
    end
  end
end
