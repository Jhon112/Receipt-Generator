#!/usr/bin/env ruby
require "json"
require_relative "receipt_generator"

class Main
  @@products_array = nil
  @@products_selected = []

  def self.app
    fetch_products
    option = 0

    while option != "4"
      puts "1. View Product List"
      puts "2. Add Product"
      puts "3. View Receipt"
      puts "4. Exit"
      option = gets.chomp

      if option == "1"
        Main.list_products
      elsif option == "2"
        Main.add_products
      elsif option == "3"
        Main.print_receipt
        break
      end
    end
  end

  def self.fetch_products
    begin
      products_json = File.read("db/products.json")
      @@products_array = JSON.parse(products_json)
    rescue => exception
      puts "Error reading the product file. Please make sure there is a products.json file with the product list."
      puts exception
    end
  end

  def self.list_products
    puts "Product List"
    puts "-----------------"
    @@products_array.each_with_index do |product, index|
      puts "#{index + 1}. #{product["name"]}: $#{product["price"]} - Exempt: #{product["exempt"]} - Imported: #{product["imported"]}"
    end
    puts "----------------"
  end

  def self.add_products
    puts "Add Product"
    puts "----------------"
    puts "Select the number of the product you want to add:"
    selected_product = gets.chomp.to_i
    puts "Enter the quantity of products you want to add:"
    quantity = gets.chomp.to_i

    product = @@products_array[selected_product - 1]
    @@products_selected << [product["name"], product["price"].to_f, product["exempt"], product["imported"], quantity]

    puts "----------------"
    puts "#{quantity} #{product["name"]} added at #{product["price"].to_f}"
    puts "----------------"
  end

  def self.print_receipt
    begin
      puts "Receipt"
      puts "----------------"
      ReceiptGenerator.generate_receipt(@@products_selected)
    rescue => exception
      puts "You must add products before generating a receipt."
      puts "----------------"
      puts exception
    end
  end
end

Main.app
