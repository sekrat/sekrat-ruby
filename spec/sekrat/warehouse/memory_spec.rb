require 'sekrat/warehouse/memory'
require 'securerandom'

module Sekrat
  module Warehouse
    RSpec.describe Memory do
      let(:warehouse) {described_class.new}

      it 'is a Warehouse' do
        expect(warehouse).to be_a(Warehouse::Base)
      end

      describe '#ids' do
        let(:storage) {warehouse.instance_eval {storage}}

        it 'is the keys for the internal storage hash' do
          expect(warehouse.ids).to eql(storage.keys)
        end
      end

      describe '#retrieve' do
        let(:id) {SecureRandom.hex(5)}
        let(:data) {SecureRandom.hex(32)}
        let(:storage) {warehouse.instance_eval {storage}}

        context 'when the id is not known' do
          before(:each) do
            storage.delete(id)
          end

          it 'raises an error' do
            expect {warehouse.retrieve(id)}.to raise_error(Sekrat::NotFound)
          end
        end

        context 'when the id is known' do
          before(:each) do
            storage[id] = data
          end

          it 'is the stored value for the id' do
            expect(warehouse.retrieve(id)).to eql(data)
          end
        end
      end

      describe '#store' do
        let(:id) {SecureRandom.hex(5)}
        let(:data) {SecureRandom.hex(32)}
        let(:storage) {warehouse.instance_eval {storage}}

        context 'when the id is not yet known' do
          it 'stores the given data for the given id' do
            expect(storage.keys).not_to include(id)

            warehouse.store(id, data)

            expect(storage[id]).to eql(data)
          end
        end

        context 'when the id is already known' do
          before(:each) do
            storage[id] = data
          end

          it 'overwrites the old data' do
            warehouse.store(id, data.reverse)

            expect(storage[id]).to eql(data.reverse)
          end
        end
      end
    end
  end
end
