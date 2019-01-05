require 'sekrat/errors'

module Sekrat
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
        warehouse.store(
          id,
          crypter.encrypt(key, data)
        )

        data
      rescue EncryptFailure
        raise EncryptFailure.new("could not encrypt '#{id}'")
      rescue StorageFailure
        raise StorageFailure.new("could not store '#{id}'")
      rescue => e
        raise Error.new(
          "an unknown error (#{e}) occurred trying to save '#{id}'"
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
      rescue => e
        raise Error.new(
          "an unknown error (#{e}) occurred trying to load '#{id}'"
        )
      end
    end

  end
end
