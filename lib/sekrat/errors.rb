module Sekrat

  # The base error for all other Sekrat errors
  Error = Class.new(StandardError)

  # An issue came up while attempting to decrypt data
  DecryptFailure = Class.new(Error)
  # An issue came up while attempting to encrypt data
  EncryptFailure = Class.new(Error)

  # An issue came up while retrieving data
  NotFound = Class.new(Error)
  # An issue came up while storing data
  StorageFailure = Class.new(Error)

  # The Warehouse or Crypter implementation is incomplete
  NotImplemented = Class.new(Error)
end
