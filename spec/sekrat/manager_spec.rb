require 'sekrat/manager'
require 'securerandom'

module Sekrat
  RSpec.describe Manager do
    let(:warehouse) {Object.new}
    let(:crypter) {Object.new}
    let(:manager) {described_class.new(warehouse: warehouse, crypter: crypter)}

    before(:each) do
      allow(warehouse).to receive(:ids)
      allow(warehouse).to receive(:retrieve)
      allow(warehouse).to receive(:store)
      
      allow(crypter).to receive(:encrypt)
      allow(crypter).to receive(:decrypt)
    end

    describe '#warehouse' do
      it 'is the warehouse with which the manager was configured' do
        expect(manager.warehouse).to eql(warehouse)
      end
    end

    describe '#crypter' do
      it 'is the crypter with which the manager was configured' do
        expect(manager.crypter).to eql(crypter)
      end
    end

    describe '#ids' do
      let(:ids) {manager.ids}

      it 'is the ids known to the warehouse' do
        expect(warehouse).to receive(:ids).and_return("sammy")

        expect(ids).to eql("sammy")
      end
    end

    describe '#put' do
      let(:id) {SecureRandom.hex(5)}
      let(:key) {SecureRandom.hex(8)}
      let(:data) {SecureRandom.hex(32)}
      let(:crypted_data) {SecureRandom.hex(32)}

      let(:put) {manager.put(id, key, data)}

      before(:each) do
        allow(crypter).
          to receive(:encrypt).
          with(key, data).
          and_return(crypted_data)

        allow(warehouse).
          to receive(:store).
          with(id, crypted_data)
      end

      it 'encrypts the data' do
        expect(crypter).
          to receive(:encrypt).
          with(key, data).
          and_return(crypted_data)

        put
      end

      it 'stores the crypted data' do
        expect(warehouse).
          to receive(:store).
          with(id, crypted_data)

        put
      end

      context 'when all goes well' do
        it 'is the original data' do
          expect(put).to eql(data)
        end
      end

      context 'when storage fails' do
        before(:each) do
          allow(warehouse).
            to receive(:store).
            with(id, crypted_data).
            and_raise(Sekrat::StorageFailure)
        end

        it 'raises an error' do
          expect {put}.to raise_error(Sekrat::StorageFailure)
        end
      end

      context 'when encryption fails' do
        before(:each) do
          allow(crypter).
            to receive(:encrypt).
            with(key, data).
            and_raise(Sekrat::EncryptFailure)
        end

        it 'raises an error' do
          expect {put}.to raise_error(Sekrat::EncryptFailure)
        end
      end

      context 'when an unknown error happens' do
        before(:each) do
          allow(warehouse).
            to receive(:store).
            with(id, crypted_data).
            and_raise("bloody murder")
        end

        it 'raises an error' do
          expect {put}.to raise_error(Sekrat::Error)
        end
      end
    end

    describe '#get' do
      let(:id) {SecureRandom.hex(5)}
      let(:key) {SecureRandom.hex(8)}
      let(:data) {SecureRandom.hex(32)}
      let(:crypted_data) {SecureRandom.hex(32)}

      let(:get) {manager.get(id, key)}

      before(:each) do
        allow(crypter).
          to receive(:decrypt).
          with(key, crypted_data).
          and_return(data)

        allow(warehouse).
          to receive(:retrieve).
          with(id).
          and_return(crypted_data)
      end

      it 'retrieves the crypted data' do
        expect(warehouse).
          to receive(:retrieve).
          with(id).
          and_return(crypted_data)

        get
      end

      it 'decrypts the crypted data' do
        expect(crypter).
          to receive(:decrypt).
          with(key, crypted_data).
          and_return(data)

        get
      end

      context 'when nothing goes wrong' do
        it 'is the decrypted data' do
          expect(get).to eql(data)
        end
      end

      context 'when decryption fails' do
        before(:each) do
          allow(crypter).
            to receive(:decrypt).
            with(key, crypted_data).
            and_raise(Sekrat::DecryptFailure)
        end

        it 'raises an error' do
          expect {get}.to raise_error(Sekrat::DecryptFailure)
        end
      end

      context 'when retrieval fails' do
        before(:each) do
          allow(warehouse).
            to receive(:retrieve).
            with(id).
            and_raise(Sekrat::NotFound)
        end

        it 'raises an error' do
          expect {get}.to raise_error(Sekrat::NotFound)
        end
      end

      context 'when an unknown error happens' do
        before(:each) do
          allow(warehouse).
            to receive(:retrieve).
            with(id).
            and_raise("bloody murder")
        end

        it 'raises an error' do
          expect {get}.to raise_error(Sekrat::Error)
        end
      end


    end
  end
end
