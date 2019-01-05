require 'sekrat/errors'

module Sekrat
  module Crypter

    # A base mixin for would-be Sekrat::Crypter implementations
    module Base

      # A stub for incomplete warehouse implementations
      # @param key [String] a key that will never get used
      # @param data [String] some data that will never get used
      # @raise [Sekrat::NotImplemented]
      def encrypt(key, data)
        raise NotImplemented.new("encrypt is not implemented")
      end

      # A stub for incomplete warehouse implementations
      # @param key [String] a key that will never get used
      # @param data [String] some data that will never get used
      # @raise [Sekrat::NotImplemented]
      def decrypt(key, data)
        raise NotImplemented.new("decrypt is not implemented")
      end
    end
  end
end
