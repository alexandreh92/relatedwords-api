module Datamuse
  module Adapters
    class BaseAdapter
      include Parseable

      attr_reader :data

      def initialize(data)
        @data = data
      end
    end
  end
end
