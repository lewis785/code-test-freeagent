# frozen_string_literal: true

# Public: Is a base class to be used by all converter class
class BaseConverter
  # Public: Initialize a BaseConverter
  #
  # filename - String representing the path to the file being converted
  def initialize(filename)
    @filename = filename
  end

  # Public: function to be implemented by extended classes to convert file types to hash
  #
  # Raises RuntimeError so that the method is implemented in any extended classes
  def convert
    raise "Don't forget to implement the convert method"
  end
end
