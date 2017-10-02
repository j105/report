require 'json'

module Piawe
  class PeopleJsonParser < JsonParser

    def target_key
      :people
    end

    def data_transformation(person)
      {
        name: person[:name],
        injuryDate: person[:injuryDate],
        hourlyRate: person[:hourlyRate].to_f,
        overtimeRate: person[:overtimeRate].to_f,
        normalHours: person[:normalHours].to_f,
        overtimeHours: person[:overtimeHours].to_f,
      }
    end

    def include_all_fileds?(hash)
      [:name,
       :injuryDate,
       :hourlyRate,
       :overtimeRate,
       :normalHours,
       :overtimeHours].all? {|s| hash.key? s}
    end
  end
end
