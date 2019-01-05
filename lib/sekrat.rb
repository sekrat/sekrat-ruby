require "sekrat/version"

require 'sekrat/crypter/passthrough'
require 'sekrat/manager'
require 'sekrat/warehouse/memory'

module Sekrat
  def self.manager(warehouse: nil, crypter: nil)
    Manager.new(
      warehouse: warehouse || Warehouse::Memory.new,
      crypter: crypter || Crypter::Passthrough.new
    )
  end
end
