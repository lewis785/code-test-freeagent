# frozen_string_literal: true

require "test/unit"
require "validator"
require "date"

# Public: unit test class for Validator
class ValidatorTest < Test::Unit::TestCase
  def setup
    @test_data = {"2020-01-01" => {"USD" => 1.2345, "GBP" => 1.1111}}
  end

  def test_base_from_currency_validation_works_as_expected
    fixture = Validator.new(@test_data, "EUR")
    fixture.validate(Date.new(2020, 1, 1), "EUR", "GBP")
  end

  def test_base_to_currency_validation_works_as_expected
    fixture = Validator.new(@test_data, "EUR")
    fixture.validate(Date.new(2020, 1, 1), "USD", "EUR")
  end

  def test_non_base_currency_validation_works_as_expected
    fixture = Validator.new(@test_data, "EUR")
    fixture.validate(Date.new(2020, 1, 1), "USD", "GBP")
  end

  def test_validation_raise_exception_when_date_not_in_data
    fixture = Validator.new(@test_data, "EUR")
    exception = assert_raise(RuntimeError) { fixture.validate(Date.new(2000, 1, 1), "USD", "GBP") }
    assert_equal "Unable to find exchange rate for specified date", exception.message
  end

  def test_validation_raise_exception_when_from_currency_invalid
    fixture = Validator.new(@test_data, "EUR")
    exception = assert_raise(RuntimeError) { fixture.validate(Date.new(2020, 1, 1), "ASDF", "GBP") }
    assert_equal "Unable to find exchange rate from currency", exception.message
  end

  def test_validation_raise_exception_when_to_currency_invalid
    fixture = Validator.new(@test_data, "EUR")
    exception = assert_raise(RuntimeError) { fixture.validate(Date.new(2020, 1, 1), "USD", "ASDF") }
    assert_equal "Unable to find exchange rate to currency", exception.message
  end
end