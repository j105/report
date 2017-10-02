require 'date'

module Piawe
  class PaymentService
    attr_reader :people, :rules, :number_of_weeks

    def initialize(people_data, rule_data)
      @people = Piawe::PeopleJsonParser.new(people_data).data
      @rules = Piawe::RuleJsonParser.new(rule_data).data
    end

    def calculate
      people.map do |person|
        injury_date = Date.parse(person[:injuryDate])
        @number_of_weeks = get_number_of_weeks(injury_date, Date.today)
        payment_on_person person
      end
    end

    private

    def get_number_of_weeks(start_date, end_date)
      (((end_date - start_date)).to_f / 7).ceil
    end

    def payment_on_person(person)
      rule = use_first_valid_rule(number_of_weeks)
      raise UndefinedRule if rule.nil?
      payment = person[:hourlyRate] * person[:normalHours]
      payment += person[:overtimeRate] * person[:overtimeHours] if rule[:overtimeIncluded]
      person.
        merge(rule).
        merge({
                amountToPay: (payment * rule[:percentagePayable]).round(2),
                weeks: number_of_weeks
              })
    end

    def use_first_valid_rule(week)
      raise UndefinedRule if week <= 0
      rules.each do |r|
        applicable_weeks = r[:applicableWeeks].split('-')
        first, last = applicable_weeks
        return r if (first.to_i..last.to_i) === week
        return r if applicable_weeks.size === 1 &&
                    applicable_weeks.last.include?('+') &&
                    week > r[:applicableWeeks].chomp('+').to_i # more than the largest week number
      end
    end
  end
end
