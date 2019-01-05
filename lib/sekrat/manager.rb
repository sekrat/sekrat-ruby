require 'sekrat/errors'

module Sekrat

  # A secret manager that coordinates both storage and encryption
  class Manager
    attr_reader :crypter, :warehouse

    def initialize(warehouse:, crypter:)
      @warehouse = warehouse
      @crypter = crypter
    end

    def ids
      warehouse.ids
    end

    def put(id, key, data)
      begin
        data.tap {|data| warehouse.store(id, crypter.encrypt(key, data))}
      rescue EncryptFailure
        raise EncryptFailure.new("could not encrypt '#{id}'")
      rescue StorageFailure
        raise StorageFailure.new("could not store '#{id}'")
      rescue => error
        raise Error.new(
          "an unknown error (#{error}) occurred trying to save '#{id}'"
        )
      end
    end

    def get(id, key)
      begin
        crypter.decrypt(
          key,
          warehouse.retrieve(id)
        )
      rescue DecryptFailure
        raise DecryptFailure.new("could not decrypt '#{id}'")
      rescue NotFound
        raise NotFound.new("could not retrieve '#{id}'")
      rescue => error
        raise Error.new(
          "an unknown error (#{error}) occurred trying to load '#{id}'"
        )
      end
    end

  end
end
