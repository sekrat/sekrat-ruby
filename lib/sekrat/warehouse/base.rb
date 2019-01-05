require 'sekrat/errors'

module Sekrat
  module Warehouse
    module Base
      def ids
        raise NotImplemented.new("ids is not implemented")
      end

      def store(id, data)
        raise NotImplemented.new("store is not implemented")
      end

      def retrieve(id)
        raise NotImplemented.new("retrieve is not implemented")
      end
    end
  end
end
