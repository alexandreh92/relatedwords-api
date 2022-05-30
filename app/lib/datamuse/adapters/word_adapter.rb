# frozen_string_literal: true

module Datamuse
  module Adapters
    class WordAdapter < BaseAdapter
      def parse
        data.map do |record|
          { value: record[:word] }
        end
      end
    end
  end
end
