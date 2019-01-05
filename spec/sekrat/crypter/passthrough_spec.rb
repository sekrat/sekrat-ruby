require 'sekrat/crypter/passthrough'
require 'securerandom'

module Sekrat
  module Crypter
    RSpec.describe Passthrough do
      let(:crypter) {described_class.new}

      it 'is a Crypter' do
        expect(crypter).to be_a(Base)
      end

      describe '#encrypt' do
        let(:key) {SecureRandom.hex(5)}
        let(:data) {SecureRandom.hex(32)}

        it 'is the original data' do
          expect(crypter.encrypt(key, data)).to eql(data)
        end
      end

      describe '#decrypt' do
        let(:key) {SecureRandom.hex(5)}
        let(:data) {SecureRandom.hex(32)}

        it 'is the original data' do
          expect(crypter.decrypt(key, data)).to eql(data)
        end
      end
    end
  end
end
