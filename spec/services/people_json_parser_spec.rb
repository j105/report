require "spec_helper"

RSpec.describe Piawe::PeopleJsonParser do
  let(:people_data) do
    File.read "spec/fixtures/people.json"
  end
  let(:instance) { Piawe::PeopleJsonParser.new(people_data) }

  describe "#data" do
    subject { instance.data}

    context "when all fields and values are present" do
      it "does not raise exception" do
        expect{ subject }.not_to raise_error
      end
    end

    context "when some fields are missing" do
      let(:people_data) {{"people": [
                            {"overtimeHours": 7.3,
                             "injuryDate": "2016/05/01" }]}.to_json}
      it "raises exception" do
        expect{ subject }.to raise_error InvalidJsonFile
      end
    end

    context "when some values are not set" do
      let(:people_data) {{"people": [
                            {"name": nil,
                            "hourlyRate": 75.0030,
                            "overtimeRate": 150.0000,
                             "normalHours": 35.0,
                             "overtimeHours": 7.3,
                             "injuryDate": "2016/05/01" }]}.to_json}
      it "raises exception" do
        expect{ subject }.to raise_error InvalidJsonFile
      end
    end
  end
end
