require "spec_helper"
require 'csv'

RSpec.describe Piawe::Report do
  let(:people_data) do
    File.read "spec/fixtures/people.json"
  end
  let(:rule_data) do
    File.read "spec/fixtures/rules.json"
  end
  let(:path) {"reports/payments_#{Date.today}.csv"}
  let(:instance) { Piawe::Report.new(people_data, rule_data) }
  around (:each) do |example|
    fix_time = Time.local(2017, 10, 2, 12, 0, 0)
    Timecop.freeze(fix_time) do
      example.run
    end
  end

  describe "#to_csv" do
    subject { instance.to_csv }

    it "generates csv file" do
      subject
      expect(Pathname.new(path).exist?).to be true
    end

    let(:expected_data) do
      JSON.parse(File.read("spec/fixtures/report.json"), symbolize_names: true)
    end

    it "includes correct rows" do
      expect(subject).to match_array(expected_data)
    end
  end
end
