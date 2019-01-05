RSpec.describe Sekrat do
  it "has a version number" do
    expect(Sekrat::VERSION).not_to be nil
  end

  describe '.manager' do
    let(:manager) {described_class.manager}

    it 'is a Manager' do
      expect(manager).to be_a(described_class::Manager)
    end

    context 'when no warehouse is configured' do
      it 'has the default warehouse (memory)' do
        expect(manager.warehouse).to be_a(described_class::Warehouse::Memory)
      end
    end

    context 'when no crypter is configured' do
      it 'has the default crypter (passthrough)' do
        expect(manager.crypter).to be_a(described_class::Crypter::Passthrough)
      end
    end
  end
end
