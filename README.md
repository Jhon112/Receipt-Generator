# Receipt Generator

This is a simple Receipt Generator application written in Ruby.

## Features

- Generates a receipt with the list of items purchased and the total amount of sales tax and total price.
- Supports multiple items and quantities
- Supports items that are exempt from basic sales tax, items that are subject to import duty, or both.

## Requirements

- Ruby 2.5 or higher
- RSpec for running tests

## Usage

1. Clone the repository.

```
git clone https://github.com/Jhon112/receipt-generator.git
```

2. Change into the project directory.

```
cd receipt-generator
```

3. Run the tests to make sure everything is working correctly.

```
rspec
```

4. To run the app please make sure to first update the "lib/main.rb" file's permissions to works as an exectuable. To do this run:

```
chmod +x lib/main.rb
```

5. Run the exectuable file by running the following command:

```
./lib/main.rb
```

*Note: Make sure you're in the root folder and not in the /lib folder. Otherwise, the app will fail due to the path to read the \products.json' file

## Development

Feel free to fork the repository and submit pull requests.

## License

This project is licensed under the MIT License.
