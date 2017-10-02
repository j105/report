require 'csv'

module Piawe
  class CsvBuilder
    def build(data)
      CSV.open("reports/payments_#{Date.today}.csv", 'wb') do |csv|
        csv << data.first.keys
        data.each do |hash|
          csv << hash.values
        end
      end
    end
  end
end
