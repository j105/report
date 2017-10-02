require 'json'

module Piawe
  class RuleJsonParser < JsonParser
    attr_reader :file

    def target_key
      :rules
    end

    def data_transformation(rule)
      rule.merge({
        percentagePayable: rule[:percentagePayable].to_f / 100,
        overtimeIncluded: rule[:overtimeIncluded]
      })
    end

    def include_all_fileds?(hash)
      [:applicableWeeks,
       :percentagePayable,
       :overtimeIncluded].all? {|s| hash.key? s}
    end
  end
end
