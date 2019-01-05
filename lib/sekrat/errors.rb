module Sekrat
  Error = Class.new(StandardError)

  DecryptFailure = Class.new(Error)
  EncryptFailure = Class.new(Error)

  NotFound = Class.new(Error)
  StorageFailure = Class.new(Error)

  NotImplemented = Class.new(Error)
end
