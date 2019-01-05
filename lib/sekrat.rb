require "sekrat/version"

require 'sekrat/crypter/passthrough'
require 'sekrat/manager'
require 'sekrat/warehouse/memory'

# An embedded key/value store with pluggable storage and encryption
module Sekrat

  # Create a new secret manager. If a warehouse is provided, that warehouse is
  # used for the manager. Otherwise, the default warehouse, Memory, is used. IF
  # a crypter is provided, that crypter is used for the manager. Otherwise, the
  # default crypter, Passthrough, is used.
  #
  # @param warehouse: [Sekrat::Warehouse::Base] the warehouse in which to store
  #   secrets
  # @param crypter: [Sekrat::Crypter::Base] the crypter with which to encrypt
  #   and decrypt secrets
  # @return [Sekrat::Manager]
  def self.manager(warehouse: nil, crypter: nil)
    Manager.new(
      warehouse: warehouse || Warehouse::Memory.new,
      crypter: crypter || Crypter::Passthrough.new
    )
  end
end
