# These are just suggested definitions to get you started.  Please feel
# free to make any changes at all as you see fit.

# http://test-unit.github.io/
require "test/unit"
require "currency_exchange"
require "date"

# Public: unit test class for CurrencyExchange
class CurrencyExchangeTest < Test::Unit::TestCase
  def setup
    Object.send(:remove_const, :CurrencyExchange) if Module.const_defined?(:CurrencyExchange)
    load "currency_exchange.rb"
  end

  def test_base_currency_returns_default_value
    correct_base_currency = "EUR"
    assert_equal correct_base_currency, CurrencyExchange.base_currency
  end

  def test_base_currency_setter_works_as_expected
    correct_base_currency = "ABC"
    CurrencyExchange.base_currency = "ABC"
    assert_equal correct_base_currency, CurrencyExchange.base_currency
  end

  def test_data_file_returns_default_value
    correct_data_file = "./data/eurofxref-hist-90d.json"
    assert_equal correct_data_file, CurrencyExchange.data_file
  end

  def test_data_file_setter_works_as_expected
    correct_data_file = "./test.txt"
    CurrencyExchange.data_file = "./test.txt"
    assert_equal correct_data_file, CurrencyExchange.data_file
  end

  def test_non_base_currency_exchange_is_correct
    correct_rate = 1.2870493690602498
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018, 11, 22), "GBP", "USD")
  end

  def test_from_base_currency_exchange_is_correct
    correct_rate = 128.8
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018, 11, 22), "EUR", "JPY")
  end

  def test_to_base_currency_exchange_is_correct
    correct_rate = 0.007763975155279502
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018, 11, 22), "JPY", "EUR")
  end

  def test_from_base_to_base_currency_exchange_is_correct
    correct_rate = 1
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018, 11, 22), "EUR", "EUR")
  end

  def test_currency_exchange_invalid_date
    exception = assert_raise(RuntimeError) { CurrencyExchange.rate(Date.new(2017, 11, 22), "GBP", "USD") }
    assert_equal "Unable to find exchange rate for specified date", exception.message
  end

  def test_currency_exchange_invalid_from_currency
    exception = assert_raise(RuntimeError) { CurrencyExchange.rate(Date.new(2018, 11, 22), "ABC", "USD") }
    assert_equal "Unable to find exchange rate from currency", exception.message
  end

  def test_currency_exchange_invalid_to_currency
    exception = assert_raise(RuntimeError) { CurrencyExchange.rate(Date.new(2018, 11, 22), "JPY", "ABC") }
    assert_equal "Unable to find exchange rate to currency", exception.message
  end
end
