require 'spec_helper'
require 'jasmine_results'
require 'sample_results'

describe Jasmine::Sauce::CI::JasmineResults do

  let(:under_test) { Jasmine::Sauce::CI::JasmineResults.new(suites, suite_results) }

  describe "#suites" do
    subject { under_test.suites }

    context "when no suites" do
      let(:suites) { {} }
      let(:suite_results) { {} }
      it { should be_empty }
    end

    context "when suites" do
      include_context "suites sample"
      let(:suite_results) { {} }
      it { should eq(suites) }
    end
  end

  describe "#for_spec_id" do
    let(:spec_id) { "1" }
    let(:suites) { {} }
    subject { under_test.for_spec_id(spec_id) }

    context "when unknown spec id" do
      let(:suite_results) { {} }
      it { should be_nil }
    end

    context "when valid spec id" do
      include_context "suite result sample"
      it { should eq(suite_results["1"]) }
    end
  end
end