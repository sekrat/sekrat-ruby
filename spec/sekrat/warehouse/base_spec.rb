require 'sekrat/warehouse/base'
require 'securerandom'

module Sekrat
  module Warehouse
    RSpec.describe Base do
      let(:warehouse) {Object.new}
      
      before(:each) do
        warehouse.extend(described_class)
      end

      describe '#ids' do
        it 'raises an error' do
          expect {warehouse.ids}.to raise_error(Sekrat::NotImplemented)
        end
      end

      describe '#retrieve' do
        let(:id) {SecureRandom.hex(5)}

        it 'raises an error' do
          expect {warehouse.retrieve(id)}.
            to raise_error(Sekrat::NotImplemented)
        end
      end

      describe '#store' do
        let(:id) {SecureRandom.hex(5)}
        let(:data) {SecureRandom.hex(32)}

        it 'raises an error' do
          expect {warehouse.store(id, data)}.
            to raise_error(Sekrat::NotImplemented)
        end
      end
    end
  end
end
