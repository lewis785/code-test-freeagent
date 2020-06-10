# frozen_string_literal: true

require "date"

# Public: provides a method to calculate the exchange rate between two currencies
class RateCalculator
  # Public: Initialize a RateCalculator
  #
  # validator - Validator use to check if the requested conversion is valid
  # exchange_rates - Hash containing exchange rates form {string => {string => float}}
  # base_currency - String representing the base currency used in the exchange rates
  def initialize(validator, exchange_rates, base_currency)
    @validator = validator
    @exchange_rates = exchange_rates
    @base_currency = base_currency
  end

  # Public: calculates the exchange rate from one currency to another on a specific date
  #
  # date - The Date of the exchange rate
  # from_currency - The String for the the currency we are exchanging from
  # to_currency - The String for the the currency we are exchanging into
  #
  # Returns Float value representing the exchange rate from the starting currency to the end currency
  # Returns Float value representing the exchange rate from the starting currency to the end currency
  def calculate(date, from_currency, to_currency)
    raise "Validator is missing validate method" unless @validator.respond_to? :validate

    @validator.validate(date, from_currency, to_currency)

    return base_currency_to_currency(date, to_currency) if from_currency == @base_currency

    return from_currency_to_base_currency(date, from_currency) if to_currency == @base_currency

    from_and_to_non_base_currency(date, from_currency, to_currency)
  end

  private

  # Private: retrieve the exchanges from base currency to target currency by looking up exchange_rates hash
  #
  # date - The Date of the exchange rate
  # to_currency - The String for the the currency we are exchanging into
  #
  # Returns Float value representing the exchange rate from base currency to target currency
  def base_currency_to_currency(date, to_currency)
    currency_rate(date, to_currency)
  end

  # Private: calculates the exchange rate from a currency into the base currency
  #
  # date - The Date of the exchange rate
  # from_currency - The String for the the currency we are exchanging from
  #
  # Returns Float value representing the exchange rate from the currency to the base currency
  def from_currency_to_base_currency(date, from_currency)
    1 / currency_rate(date, from_currency)
  end

  # Private: calculates the exchange rate for converting from a non-base currency into a non-base currency
  #
  # date - The Date of the exchange rate
  # from_currency - The String for the the currency we are exchanging from
  # to_currency - The String for the the currency we are exchanging into
  #
  # Returns A Float value representing the exchange rate from the starting currency to the end currency
  def from_and_to_non_base_currency(date, from_currency, to_currency)
    from_currency_to_base_currency(date, from_currency) * currency_rate(date, to_currency)
  end

  # Private: retrieves the exchange rate for the specified currency on the specified date
  #
  # date - The Date of the exchange rate
  # currency - The String for the currency that the exchange rate is being gotten for
  #
  # Return Float representing the exchange rate from the base currency into the currency
  def currency_rate(date, currency)
    return 1 if currency == @base_currency

    @exchange_rates[date.strftime("%Y-%m-%d")][currency]
  end
end
