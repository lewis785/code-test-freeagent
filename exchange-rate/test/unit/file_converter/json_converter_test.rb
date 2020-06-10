# frozen_string_literal: true

require "test/unit"

# Public: unit test class for JsonConverterTest
class JsonConverterTest < Test::Unit::TestCase
  def test_convert
    fixture = JsonConverter.new("test.json")
    File.stubs(:read).returns("{\"2020-01-01\": {\"USD\": 1.23456}}")
    File.stubs(:file?).returns(true)

    correct_convert = {"2020-01-01" => {"USD" => 1.23456}}
    assert_equal correct_convert, fixture.convert
  end

  def test_convert_raise_exception_on_invalid_json
    fixture = JsonConverter.new("test.json")
    File.stubs(:read).returns("{\"2020-01-01\": {\"USD\": 1.23456}")
    File.stubs(:file?).returns(true)

    assert_raise(JSON::ParserError) { fixture.convert }
  end

  def test_convert_raise_exception_when_file_does_not_exist
    fixture = JsonConverter.new("test.json")
    File.stubs(:file?).returns(false)

    exception = assert_raise(RuntimeError) { fixture.convert }
    assert_equal "Data file does not exist", exception.message
  end
end