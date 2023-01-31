#!/usr/bin/env ruby
require 'json'
require_relative "receipt_generator"

def main
  products_selected = []
  option = 0
  products_array = fetch_products
  
  while option != '4'
    puts '1. View Product List'
    puts '2. Add Product'
    puts '3. View Receipt'
    puts '4. Exit'
    option = gets.chomp

    if option == '1'
      puts 'Product List'
      puts '-----------------'
      begin
        products_array.each_with_index do |product, index|
          puts "#{index + 1}. #{product['name']}: $#{product['price']} - Exempt: #{product['exempt']} - Imported: #{product['imported']}"
        end
        puts '----------------'
      rescue => exception
        puts 'Error reading the product file. Please make sure there is a products.json file with the product list.'
        puts exception
      end

    elsif option == '2'
      puts 'Add Product'
      puts '----------------'
      puts 'Select the number of the product you want to add:'
      selected_product = gets.chomp.to_i
      puts 'Enter the quantity of products you want to add:'
      quantity = gets.chomp.to_i
      
      begin
        product = products_array[selected_product - 1]
        products_selected << [product['name'], product['price'].to_f, product['exempt'], product['imported'], quantity]
        puts '----------------'
        puts "#{quantity} #{product['name']} added at #{product['price'].to_f}"
        puts '----------------'
      rescue => exception
        puts 'Error reading the product file. Please make sure there is a products.json file with the product list.'
        puts exception
      end
    elsif option == '3'
      puts 'Receipt'
      puts '----------------'
      begin
        ReceiptGenerator.generate_receipt(products_selected)
        break
      rescue => exception
        puts "You must add products before generating a receipt."
        puts '----------------'
        puts exception
      end
    end
  end
end

def fetch_products
  begin
    products_json = File.read('db/products.json')
    products_array = JSON.parse(products_json)

    products_array
  rescue => exception
    puts 'Error reading the product file. Please make sure there is a products.json file with the product list.'
    puts exception
  end
end

main
