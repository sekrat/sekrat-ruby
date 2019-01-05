require 'sekrat/errors'

module Sekrat
  module Crypter
    module Base
      def encrypt(key, data)
        raise NotImplemented.new("encrypt is not implemented")
      end

      def decrypt(key, data)
        raise NotImplemented.new("decrypt is not implemented")
      end
    end
  end
end