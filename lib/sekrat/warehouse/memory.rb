require 'sekrat/warehouse/base'

module Sekrat
  module Warehouse
    class Memory
      include Base

      def initialize
        @storage = {}
      end

      def ids
        storage.keys
      end

      def store(id, data)
        storage[id] = data
      end

      def retrieve(id)
        raise NotFound.new("id '#{id}'") unless ids.include?(id)

        storage[id]
      end

      private
      def storage
        @storage
      end
    end
  end
end
