require 'spec_helper'
require 'selenium_runner'
require 'jasmine_results'
require 'sample_results'

describe Jasmine::Sauce::CI::SeleniumRunner do

  let(:driver) { double("Driver") }
  let(:url) { "jasmine.url" }
  let(:under_test) { Jasmine::Sauce::CI::SeleniumRunner.new(driver) }

  describe "#run" do
    subject { under_test.run(url) }

    let(:load_timeout) { 0.01 }
    before do
      driver.should_receive(:connect).with(url)
      under_test.should_receive(:load_jasmine_timeout).and_return(load_timeout)
    end

    context "when loading jasmine times out" do
      before do
        driver.should_receive(:evaluate_js).and_return(false, false)
      end
      specify { expect {subject}.to raise_error("Timed out after #{load_timeout}s waiting for Jasmine to load") }
    end

    context "when jasmine execution times out" do
      let(:load_result) { true }
      let(:suites) { {} }
      let(:jasmine_finished_result) { false }
      before do
        under_test.should_receive(:jasmine_execution_timeout).and_return(load_timeout)
        driver.should_receive(:evaluate_js).and_return(load_result, suites, jasmine_finished_result, jasmine_finished_result)
      end
      specify { expect {subject}.to raise_error("Timed out after #{load_timeout}s waiting for Jasmine to finish") }
    end

    context "when there are no suites" do
      let(:load_result) { true }
      let(:suites) { {} }
      let(:jasmine_finished_result) { true }
      let(:suite_results) { {} }

      before do
        under_test.should_receive(:jasmine_execution_timeout).and_return(load_timeout)
        driver.should_receive(:evaluate_js).and_return(load_result, suites, jasmine_finished_result)
        driver.should_receive(:disconnect)
      end

      it("should return no suites") { subject.suites.should be_empty }
      it("should return no suite results") { subject.for_spec_id('0').should be_nil }
    end

    shared_context "selenium runner is successful" do
      include_context "suites sample"
      include_context "suite result sample"

      let(:load_result) { true }
      let(:jasmine_finished_result) { true }

      before do
        under_test.should_receive(:jasmine_execution_timeout).and_return(load_timeout)
        driver.should_receive(:disconnect)
      end

      it("should return suites") { subject.suites.should eq(suites) }
      it("should return suite results") { subject.for_spec_id('0').should eq(suite_results['0']) }
    end

    context "when there are suites" do
      include_context "selenium runner is successful"

      before {
        driver.should_receive(:evaluate_js).and_return(load_result, suites, jasmine_finished_result, suite_results)
      }
    end

    context "when suites exceed batch size" do
      let(:batch_size) { 1 }
      let(:under_test) { Jasmine::Sauce::CI::SeleniumRunner.new(driver, batch_size) }
      include_context "selenium runner is successful"

      before {
        driver.should_receive(:evaluate_js).and_return(load_result, suites, jasmine_finished_result,
                                                       suite_results.select {|k,_| k == '0'},
                                                       suite_results.select {|k,_| k == '1'},
                                                       suite_results.select {|k,_| k == '2'})
      }
    end
  end

end