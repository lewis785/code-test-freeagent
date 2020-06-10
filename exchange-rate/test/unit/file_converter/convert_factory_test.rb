# frozen_string_literal: true

require "test/unit"
require "file_converter/converter_factory"

# Public: unit test class for ConverterFactory
class ConvertFactoryTest < Test::Unit::TestCase
  def test_raise_exception_on_unsupported_file_type
    fixture = ConverterFactory.new
    exception = assert_raise(RuntimeError) { fixture.retrieve_converter("test.txt") }
    assert_equal("Unable to read file type .txt", exception.message)
  end
end