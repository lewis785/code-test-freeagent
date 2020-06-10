# frozen_string_literal: true

require "date"

# Public: provides methods for validation exchange rate data
class Validator
  # Public: Initialize a Validator
  #
  # exchange_rates - Hash containing exchange rates form {string => {string => float}}
  # base_currency - String representing the base currency used in the exchange rates
  def initialize(exchange_rates, base_currency)
    @exchange_rates = exchange_rates
    @base_currency = base_currency
  end

  # Public: validates if date, from currency, and to currency are present in exchange data
  #
  # date - The Date to be checked
  # from_currency - The String representing the starting currency
  # to_currency - The String representing the end currency
  #
  # Raises RuntimeError if date, from_currency, or to_currency are not valid
  # Returns nothing
  def validate(date, from_currency, to_currency)
    date_string = date.strftime("%Y-%m-%d")

    raise "Unable to find exchange rate for specified date" unless @exchange_rates.key?(date_string)

    currencies = @exchange_rates[date_string]

    raise "Unable to find exchange rate from currency" unless valid_currency(currencies, from_currency)

    raise "Unable to find exchange rate to currency" unless valid_currency(currencies, to_currency)
  end

  private

  # Private: check if currency is valid
  #
  # currencies - The Hash in the form {string => float} representing currencies to exchange rates
  # currency - The String for the currency which is being validated
  #
  # Examples
  #
  #   valid_currency({"USD" => 1.123}, "USD")
  #   # => true
  #
  #   valid_currency({"USD" => 1.123}, "GBP")
  #   # => false
  #
  # Returns true if currency exists in currencies or currency is the base currency, false otherwise
  def valid_currency(currencies, currency)
    currencies.key?(currency) || currency == @base_currency
  end
end
