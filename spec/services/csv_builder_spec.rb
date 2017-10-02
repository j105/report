require "spec_helper"
require 'csv'

RSpec.describe Piawe::CsvBuilder do
  let(:data) {[{:key1=>"value1",
               :key2=>"value2",
               :key3=>"value3"}]}
  let(:path) {"reports/payments_#{Date.today}.csv"}
  let(:instance) { Piawe::CsvBuilder.new }

  subject(:contents) do
    instance.build data
    CSV.read path
  end

  around (:each) do |example|
    fix_time = Time.local(2017, 10, 2, 12, 0, 0)
    Timecop.freeze(fix_time) do
      example.run
    end
  end

  describe "report header" do
    subject { contents.first }

    let(:expected_data) do
      ["key1", "key2", "key3"]
    end

    it "contains data keys" do
      expect(subject).to eq(expected_data)
    end
  end

  describe "report data row" do
    subject { contents.last }

    let(:expected_data) do
      ["value1", "value2", "value3"]
    end

    it "contains data values" do
      expect(subject).to eq(expected_data)
    end
  end
end
