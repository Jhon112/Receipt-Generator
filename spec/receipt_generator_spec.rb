RSpec.describe ReceiptGenerator do
  describe '.generate_receipt' do
    context 'with empty items list' do
      it 'raises an argument error' do
        expect { described_class.generate_receipt([]) }.to raise_error(ArgumentError, 'The item list cannot be empty')
      end
    end

    context 'with a list of items' do
      let(:items) do
        [
          ['local product 1', 10.99, false, false, 1],
          ['imported product 2', 20.15, false, true, 1],
          ['exempt product 3', 30.45, true, false, 1],
          ['local product 4', 40.50, false, false, 1],
        ]
      end


      it 'returns the receipt' do
        expect(described_class.generate_receipt(items)).to eq([
          "1 local product 1 at 12.09",
          "1 imported product 2 at 23.20",
          "1 exempt product 3 at 30.45",
          "1 local product 4 at 44.55",
          "Sales Taxes: 8.20",
          "Total: 110.29"
        ])
      end
    end
  end
end