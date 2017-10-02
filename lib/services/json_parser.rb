require 'json'

module Piawe
  class JsonParser
    attr_reader :file
    def initialize(file)
      @file = file
    end

    def data
      items = parse[target_key]
      items.map do |item|
        unless include_all_fileds?(item) &&
          include_all_values_of_keys?(item)
          raise InvalidJsonFile
        end
        data_transformation(item)
      end
    end

    private

    def parse
      JSON.parse file, symbolize_names: true
    end

    def include_all_values_of_keys?(hash)
      hash.values.all? {|v| !v.nil?}
    end
  end
end
