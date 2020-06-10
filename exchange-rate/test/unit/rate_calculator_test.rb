# frozen_string_literal: true

require "test/unit"
require "mocha/test_unit"
require "file_converter/json_converter"

# Public: unit test class for RateCalculatorTest
class RateCalculatorTest < Test::Unit::TestCase
  def setup
    @base_currency = "EUR"
    @test_data = {"2020-01-01" => {"USD" => 1.123456, "GBP" => 1.54321}}

    @validator = mock
    @validator.stubs(:validate).returns(true)
    @validator.stubs(:respond_to?).returns(true)
  end

  def test_calculator_from_base_currency
    fixture = RateCalculator.new(@validator, @test_data, @base_currency)

    correct_rate = 1.54321
    assert_equal correct_rate, fixture.calculate(Date.new(2020, 1, 1), "EUR", "GBP")
  end

  def test_calculator_to_base_currency
    fixture = RateCalculator.new(@validator, @test_data, @base_currency)

    correct_rate = 0.6479999481600042
    assert_equal correct_rate, fixture.calculate(Date.new(2020, 1, 1), "GBP", "EUR")
  end

  def test_calculator_from_non_base_to_non_base_currency
    fixture = RateCalculator.new(@validator, @test_data, @base_currency)

    correct_rate = 1.3736274495841403
    assert_equal correct_rate, fixture.calculate(Date.new(2020, 1, 1), "USD", "GBP")
  end
end