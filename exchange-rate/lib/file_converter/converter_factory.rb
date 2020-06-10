# frozen_string_literal: true

require_relative "json_converter"

# Public: provides method used to retrieve the required file converter class for a provided filename
class ConverterFactory
  # Public: Retrieves file converter require to convert exchange rate data files into a usable structure
  #
  # filename - The name of the file as a String
  #
  # Examples
  #
  #   retrieve_converter("test.json")
  #   # => JsonConvert.new("test.json")
  #
  # Raises RuntimeError when a file with an unsupported extension type is provided
  # Returns BaseConverter which is implemented by other converter classes
  def retrieve_converter(filename)
    file_type = File.extname(filename)
    case file_type
    when ".json"
      JsonConverter.new(filename)
    else
      raise "Unable to read file type #{file_type}"
    end
  end
end
