require 'sekrat/crypter/base'

module Sekrat
  module Crypter

    # A crypter that doesn't actually do any crypting
    class Passthrough
      include Base

      # Given a key and some data, use that key to encrypt the data.
      # @param key [String] the encryption key to use
      # @param data [String] the data to encrypt
      # @return [String] the original data
      def encrypt(key, data)
        data
      end

      # Given a key and some data, use that key to decrypt the data.
      # @param key [String] the encryption key to use
      # @param data [String] the data to decrypt
      # @return [String] the decrypted data
      def decrypt(key, data)
        data
      end
    end
  end
end
