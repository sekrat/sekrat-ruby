require 'sekrat/errors'

module Sekrat
  module Warehouse

    # A base mixin for would-be Sekrat::Warehouse implementations
    module Base

      # A stub for incomplete warehouse implementations
      # @raise [Sekrat::NotImplemented]
      def ids
        raise NotImplemented.new("ids is not implemented")
      end

      # A stub for incomplete warehouse implementations
      # @param id [String] an ID that will never get used
      # @param data [String] some data that will never get used
      # @raise [Sekrat::NotImplemented]
      def store(id, data)
        raise NotImplemented.new("store is not implemented")
      end

      # A stub for incomplete warehouse implementations
      # @param id [String] an id that will never get used
      # @raise [Sekrat::NotImplemented]
      def retrieve(id)
        raise NotImplemented.new("retrieve is not implemented")
      end
    end
  end
end
