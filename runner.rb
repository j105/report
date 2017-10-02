require_relative "./lib/report.rb"
Piawe::Report.new.to_csv
puts "Please find the report file at reports/payments_#{Date.today}.csv"
