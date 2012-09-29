require_relative 'spec_helper'
require_relative 'vcr_helper'
require 'jasmine-selenium-sauce'
require 'browser_config'
require 'sauce_config'
require 'reporter_fake'

describe Jasmine::Sauce::CI::Main do

  describe "#run_via_browser" do

    pending "These tests disabled for CI because they currently depend on an actual browser"

    let(:config) { Jasmine::Sauce::CI::BrowserConfig.new }
    let(:reporter) { ReporterFake.new }
    subject { Jasmine::Sauce::CI::Main.run_via_browser(config, reporter) }
    after do
      ENV.delete('JASMINE_URL')
      ENV.delete('LOCAL_BROWSER')
    end

    context "when there are no failures" do
      use_vcr_cassette 'jasmine_browser_success', record: :none
      before do
        ENV['JASMINE_URL'] = 'http://localhost:3000/jasmine'
        ENV['LOCAL_BROWSER'] = 'firefox'
      end

      describe "passing tests" do
        xit { subject[:passed].should eq([0,1,2,3,4]) }
      end
      describe "failing tests" do
        xit { subject[:failed].should be_empty }
      end
    end

    context "when there are failures" do
      use_vcr_cassette 'jasmine_browser_failures', record: :none
      before do
        ENV['JASMINE_URL'] = 'http://localhost:3000/jasmine'
        ENV['LOCAL_BROWSER'] = 'firefox'
      end

      describe "passing tests" do
        xit { subject[:passed].should eq([0,2,3,4]) }
      end
      describe "failing tests" do
        xit { subject[:failed].should eq([1]) }
      end
    end

  end

  describe "#run_via_saucelabs" do

    let(:config) { Jasmine::Sauce::CI::SauceConfig.new }
    let(:reporter) { ReporterFake.new }
    subject { Jasmine::Sauce::CI::Main.run_via_saucelabs(config, reporter) }

    after do
      ENV.delete('SAUCELABS_URL')
      ENV.delete('JASMINE_URL')
      ENV.delete('SAUCE_BROWSER')
    end

    context "when there are no failures" do
      use_vcr_cassette 'jasmine_saucelabs_success', record: :none

      before do
        ENV['SAUCELABS_URL'] = 'http://username:password@ondemand.saucelabs.com:80/wd/hub'
        ENV['JASMINE_URL'] = 'http://jasmine.server.com/jasmine'
        ENV['SAUCE_BROWSER'] = 'chrome'
      end

      describe "passing tests" do
        it { subject[:passed].should eq([0,1,2]) }
      end
      describe "failing tests" do
        it { subject[:failed].should be_empty }
      end
    end

    context "when there are failures" do
      use_vcr_cassette 'jasmine_saucelabs_failures', record: :none
      before do
        ENV['SAUCELABS_URL'] = 'http://username:password@ondemand.saucelabs.com:80/wd/hub'
        ENV['JASMINE_URL'] = 'http://jasmine.server.com/jasmine'
        ENV['SAUCE_BROWSER'] = 'chrome'
      end

      describe "passing tests" do
        it { subject[:passed].should eq([0,2]) }
      end
      describe "failing tests" do
        it { subject[:failed].should eq([1]) }
      end
    end

  end
end