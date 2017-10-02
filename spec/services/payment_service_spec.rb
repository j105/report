require "spec_helper"
require 'json'
require 'date'

RSpec.describe Piawe::PaymentService do
  let(:data) do
    File.read "spec/fixtures/people.json"
  end
  let(:rule) do
    File.read "spec/fixtures/rules.json"
  end
  let(:instance) { Piawe::PaymentService.new(data, rule) }

  describe "#calculate" do
    subject { instance.calculate }

    it "returns an array" do
      expect(subject).to be_an_instance_of(Array)
    end
  end

  describe "#use_first_valid_rule" do
    subject { instance.send(:use_first_valid_rule, week) }
    context "when week number is less than 1" do
      let(:week) { 0 }

      it "raises the exception" do
        expect{ subject }.to raise_error UndefinedRule
      end
    end

    context "when week number matches a rule with week range" do
      let(:week) { 26 }
      let(:expected_data) {{:applicableWeeks=> "1-26",
                            :percentagePayable=> 0.9,
                            :overtimeIncluded=> true}}
      it "returns the matching rule" do
        expect(subject).to eq(expected_data)
      end
    end

    context "week week number matches a rule with no upper week limit" do
      let(:week) { 105 }
      let(:expected_data) {{:applicableWeeks=> "104+",
                            :percentagePayable=> 0.1,
                            :overtimeIncluded=> false}}
      it "returns the matching rule" do
        expect(subject).to eq(expected_data)
      end
    end
  end
end
