# frozen_string_literal: true

require "json"
require_relative "base_converter.rb"

# Public: Provides method to convert currency exchange json data files into standard structure for
# the rest of the program
#
# Examples
#   JsonConvert.new("test.json").convert
#   # => {"2020-01-01" => {"GBP" => 1.2345, "USD" => 1.111, ...}, ...}
class JsonConverter < BaseConverter
  # Public: converts json file into hash
  #
  # Examples
  #   JsonConvert.new("test.json").convert
  #   # => {"2020-01-01" => {"GBP" => 1.2345, "USD" => 1.111, ...}, ...}
  #
  # Returns Hash in the structure of {String->{String->Float}}
  def convert
    raise "Data file does not exist" unless File.file?(@filename)

    json_file = File.read(@filename)
    JSON.parse(json_file)
  end
end
