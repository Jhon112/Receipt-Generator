class ReceiptGenerator
  def self.generate_receipt(products)
    raise ArgumentError, "The item list cannot be empty" if products.empty?

    receipt = []
    total_taxes = 0
    total = 0

    products.each do |name, price, exempt, imported, quantity|
      taxes, total_taxes = ReceiptGenerator.taxes_calculator(price, exempt, imported, total_taxes)
      final_price = price + taxes

      total += final_price * quantity
      receipt << "#{quantity} #{name} at #{format("%.2f", final_price * quantity)}"
    end

    receipt << "Sales Taxes: #{format("%.2f", total_taxes)}"
    receipt << "Total: #{format("%.2f", total)}"
    puts receipt.join("\n")

    receipt
  end

  def self.taxes_calculator(price, exempt, imported, total_taxes)
    taxes = 0
    taxes += (price * 0.10) unless exempt
    taxes += (price * 0.05) if imported
    taxes = (taxes * 20).ceil / 20.0

    total_taxes += taxes
    [taxes, total_taxes]
  end
end
