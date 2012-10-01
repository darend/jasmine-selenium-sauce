require 'spec_helper'
require 'vcr_helper'
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

    before do
      ENV['JASMINE_URL'] = 'http://localhost:3000/jasmine'
      ENV['LOCAL_BROWSER'] = 'firefox'
    end
    after do
      ENV.delete('JASMINE_URL')
      ENV.delete('LOCAL_BROWSER')
    end

    context "when there are no failures" do
      use_vcr_cassette 'jasmine_browser_success', :match_requests_on => [:host, :path], :record => :none

      describe "passing tests" do
        xit { subject[:passed].should eq([0,1,2,3,4]) }
      end
      describe "failing tests" do
        xit { subject[:failed].should be_empty }
      end
    end

    context "when there are failures" do
      use_vcr_cassette 'jasmine_browser_failures', :match_requests_on => [:host, :path], :record => :none

      describe "passing tests" do
        xit { subject[:passed].should eq([0,2,3,4]) }
      end
      describe "failing tests" do
        xit { subject[:failed].should eq([1]) }
      end
    end

  end

  shared_examples_for 'when all tests pass' do
    describe "passing tests" do
      it { subject[:passed].should eq([0,1,2,3,4]) }
    end
    describe "failing tests" do
      it { subject[:failed].should be_empty }
    end
  end

  shared_examples_for 'when some tests fail' do
    describe "passing tests" do
      it { subject[:passed].should eq([0,2,3,4]) }
    end
    describe "failing tests" do
      it { subject[:failed].should eq([1]) }
    end
  end

  describe "#run_via_saucelabs" do

    let(:config) { Jasmine::Sauce::CI::SauceConfig.new }
    let(:reporter) { ReporterFake.new }
    subject { Jasmine::Sauce::CI::Main.run_via_saucelabs(config, reporter) }

    before do
      ENV['SAUCELABS_URL'] = 'http://username:password@ondemand.saucelabs.com:80/wd/hub'
      ENV['JASMINE_URL'] = 'http://jasmine.server.com/jasmine'
      ENV['SAUCE_BROWSER'] = 'chrome'
    end
    after do
      ENV.delete('SAUCELABS_URL')
      ENV.delete('JASMINE_URL')
      ENV.delete('SAUCE_BROWSER')
    end

    context "when there are no failures" do
      use_vcr_cassette 'jasmine_saucelabs_success', :record => :none
      it_behaves_like 'when all tests pass'
    end

    context "when there are failures" do
      use_vcr_cassette 'jasmine_saucelabs_failures', :record => :none
      it_behaves_like 'when some tests fail'
    end

  end

  describe "#run_local_via_saucelabs" do

    let(:config) { Jasmine::Sauce::CI::LocalSauceConfig.new }
    let(:reporter) { ReporterFake.new }
    let(:ssh_gateway) { double("Net::SSH::Gateway") }
    subject { Jasmine::Sauce::CI::Main.run_local_via_saucelabs(config, reporter) }

    before do
      ENV['SAUCELABS_URL'] = 'http://username:password@ondemand.saucelabs.com:80/wd/hub'
      ENV['JASMINE_PORT'] = '3000'
      ENV['SAUCE_BROWSER'] = 'chrome'
      Net::SSH::Gateway.should_receive(:new).with("3pts.localtunnel.com","localtunnel").and_return(ssh_gateway)
      ssh_gateway.stub(:open_remote) do |_,_,_,&blk|
        blk.call
      end
    end
    after do
      ENV.delete('SAUCELABS_URL')
      ENV.delete('JASMINE_PORT')
      ENV.delete('SAUCE_BROWSER')
    end

    context "when there are no failures" do
      use_vcr_cassette 'jasmine_local_saucelabs_success', :record => :none
      it_behaves_like 'when all tests pass'
    end

    context "when there are failures" do
      use_vcr_cassette 'jasmine_local_saucelabs_failures', :record => :none
      it_behaves_like 'when some tests fail'
    end

  end
end