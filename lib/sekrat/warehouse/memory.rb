require 'sekrat/warehouse/base'

module Sekrat
  module Warehouse

    # An in-memory warehouse for storing secrets
    class Memory
      include Base

      def initialize
        @storage = {}
      end

      # Get the list of ids for the secrets stored in the warehouse
      # @return [Array<String>] the list of keys
      def ids
        storage.keys
      end

      # Given an id and some data, store the data indexed by the id
      # @param id [String] the id for the secret
      # @param data [String] the data to store
      # @return [String] the data stored
      def store(id, data)
        storage[id] = data
      end

      # Given an id, get its associated stored data
      # @param id [String] the id of the secret
      # @return [String] the secret data
      # @raise [Sekrat::NotFound] if the secret does not exist
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
