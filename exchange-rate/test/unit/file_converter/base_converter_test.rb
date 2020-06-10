# frozen_string_literal: true

require "test/unit"
require "file_converter/base_converter"

# Public: unit test class for BaseConverter
class BaseConverterTest < Test::Unit::TestCase
  def test_convert_raises_exception
    fixture = BaseConverter.new("test.txt")
    exception = assert_raise(RuntimeError) { fixture.convert }
    assert_equal "Don't forget to implement the convert method", exception.message
  end
end