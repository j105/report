require "spec_helper"

RSpec.describe Piawe::PeopleJsonParser do
  let(:rule_data) do
    File.read "spec/fixtures/rules.json"
  end
  let(:instance) { Piawe::RuleJsonParser.new(rule_data) }

  describe "#data" do
    subject { instance.data }

    context "when all fields and values are present" do
      it "does not raise exception" do
        expect{ subject }.not_to raise_error
      end
    end

    context "when some fields are missing" do
      let(:rule_data) {{"rules":[
                          {"applicableWeeks": "1-26",
                           "overtimeIncluded": true}]}.to_json}
      it "raises exception" do
        expect{ subject }.to raise_error InvalidJsonFile
      end
    end

    context "when some fields are not set" do
      let(:rule_data) {{"rules":["applicableWeeks": "1-26",
                        "percentagePayable": 90,
                         "overtimeIncluded": nil ]}.to_json}
      it "raises exception" do
        expect{ subject }.to raise_error InvalidJsonFile
      end
    end
  end
end
