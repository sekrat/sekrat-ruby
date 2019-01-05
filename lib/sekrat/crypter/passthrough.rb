require 'sekrat/crypter/base'

module Sekrat
  module Crypter
    class Passthrough
      include Base

      def encrypt(key, data)
        data
      end

      def decrypt(key, data)
        data
      end
    end
  end
end
