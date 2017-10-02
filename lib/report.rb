require 'require_all'
require_all 'lib'
module Piawe
  class Report
    def initialize(people_data = "#{File.read './data/people.json'}",
                   rule_data = "#{File.read './data/rules.json'}")
      payment_service = Piawe::PaymentService.new(people_data, rule_data)
      @payment_data = payment_service.calculate
    end

    def to_csv
      Piawe::CsvBuilder.new.build(@payment_data)
    end
  end
end
