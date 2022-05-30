# frozen_string_literal: true

module Parseable
  extend ActiveSupport::Concern

  class_methods do
    def parse(...)
      new(...).parse
    end
  end
end
