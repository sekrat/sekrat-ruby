require 'sekrat/crypter/base'
require 'securerandom'

module Sekrat
  module Crypter
    RSpec.describe Base do
      let(:crypter) {Object.new}
      
      before(:each) do
        crypter.extend(described_class)
      end

      describe '#encrypt' do
        let(:key) {SecureRandom.hex(5)}
        let(:data) {SecureRandom.hex(32)}

        it 'raises an error' do
          expect {crypter.encrypt(key, data)}.
            to raise_error(Sekrat::NotImplemented)
        end
      end

      describe '#decrypt' do
        let(:key) {SecureRandom.hex(5)}
        let(:data) {SecureRandom.hex(32)}

        it 'raises an error' do
          expect {crypter.decrypt(key, data)}.
            to raise_error(Sekrat::NotImplemented)
        end
      end
    end
  end
end
