require 'sekrat/errors'

module Sekrat

  # A secret manager that coordinates both storage and encryption
  class Manager

    # @return [Sekrat::Crypter::Base] the manager's crypter
    attr_reader :crypter

    # @return [Sekrat::Warehouse::Base] the manager's warehouse
    attr_reader :warehouse

    # Initialize a new manager
    # @param warehouse: [Sekrat::Warehouse::Base] the warehouse to use for
    #   secret storage
    # @param crypter: [Sekrat::Crypter::Base] the crypter to use for encrypting
    #   and decrypting secrets
    def initialize(warehouse:, crypter:)
      @warehouse = warehouse
      @crypter = crypter
    end

    # Get the IDs that the manager knows about
    # @return [Array<String>] the list of secret IDs
    def ids
      warehouse.ids
    end

    # Given a secret id, an encryption key, and some data, encrypt the data and
    # store it, indexed by ID
    # @param id [String] the ID for the secret
    # @param key [String] the key to use for encrypting the data
    # @param data [String] the data to save
    # @return [String] the original data
    # @raise [Sekrat::EncryptFailure] if there is a problem with encrypting the
    #   data
    # @raise [Sekrat::StorageFailure] if there is a problem storing the secret
    # @raise [Sekrat::Error] if any other problem comes up
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

    # Given a secret ID and an encryption key, retrieve the decrypted secret
    # @param id [String] the ID of the secret to retrieve
    # @param key [String] the key to use to decrypt the secret
    # @return [String] the decrypted secret
    # @raise [Sekrat::DecryptFailure] if there is a problem decrypting the
    #   secret
    # @raise [Sekrat::NotFound] if the requested secret is not known
    # @raise [Sekrat::Error] if any other problem comes up
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
