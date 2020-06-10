# frozen_string_literal: true

require "file_converter/converter_factory"
require "rate_calculator"
require "validator"

# Public: Module which provides functionality to get the change rate between two currencies
module CurrencyExchange
  @data_file = "./data/eurofxref-hist-90d.json"
  @base_currency = "EUR"

  # Public: getter function for base_currency
  #
  # Example
  #
  #   CurrencyExchange.base_currency
  #   # => "EUR"
  #
  # Returns String representing the base currency
  def self.base_currency
    @base_currency
  end

  # Public: setter function for base_currency
  #
  # data_file - String representing the base currency
  #
  # Example
  #
  #   CurrencyExchange.base_currency="ABC"
  #   # => nil
  #
  # Returns nothing.
  def self.base_currency=(base_currency)
    @base_currency = base_currency
  end

  # Public: getter function for data_file
  #
  # Example
  #
  #   CurrencyExchange.data_file
  #   # => "./example_file.json"
  #
  # Returns String representing the path to the data file
  def self.data_file
    @data_file
  end

  # Public: setter function for data_file
  #
  # data_file - String representing the path to the data file
  #
  # Example
  #
  #   CurrencyExchange.data_file="./new_example_file.txt"
  #   # => nil
  #
  # Returns nothing.
  def self.data_file=(data_file)
    @data_file = data_file
  end

  # Public: method to find the exchange rate between two currencies on a specific date
  #
  # date - The Date of the exchange rate
  # from_currency - The String for the the currency we are exchanging from
  # to_currency - The String for the the currency we are exchanging into
  #
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  #
  # Returns Float representing the exchange rate between the two currencies
  def self.rate(date, from_currency, to_currency)
    rates = ConverterFactory.new.retrieve_converter(@data_file).convert
    validator = Validator.new(rates, @base_currency)
    RateCalculator.new(validator, rates, @base_currency).calculate(date, from_currency, to_currency)
  end
end
