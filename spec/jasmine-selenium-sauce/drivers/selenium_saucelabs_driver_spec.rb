require 'spec_helper'
require 'sauce_config'
require 'selenium_saucelabs_driver'
require 'sample_results'
require 'selenium_driver_fixtures'

describe Jasmine::Sauce::CI::SeleniumSauceLabsDriver do

  let(:under_test) { Jasmine::Sauce::CI::SeleniumSauceLabsDriver.new(config) }
  let(:config) { Jasmine::Sauce::CI::SauceConfig.new }
  let(:driver) { double("SeleniumWebDriver") }

  describe "#create_driver" do
    let(:selenium_client) { double("Selenium::WebDriver::Remote::Http::Default") }
    let(:timeout) { "client timeout" }
    let(:sauce_url) { "http://sauce.url" }
    let(:capabilities) { "desired capabilities" }
    subject { under_test }
    before do
      config.should_receive(:selenium_client_timeout).and_return(timeout)
      config.should_receive(:saucelabs_server_url).and_return(sauce_url)
      Selenium::WebDriver::Remote::Http::Default.should_receive(:new).and_return(selenium_client)
      selenium_client.should_receive(:timeout=).with(timeout)
      Jasmine::Sauce::CI::SeleniumSauceLabsDriver.any_instance.should_receive(:generate_capabilities).and_return(capabilities)
      Selenium::WebDriver.should_receive(:for) do | browser, options |
        browser.should eq(:remote)
        options[:http_client].should eq(selenium_client)
        options[:url].should eq(sauce_url)
        options[:desired_capabilities].should eq(capabilities)
      end
    end

    it("should interact with webdriver correctly") { subject }
  end

  shared_context "create driver is stubbed" do
    before do
      Jasmine::Sauce::CI::SeleniumSauceLabsDriver.any_instance.should_receive(:create_driver).with(config).and_return(driver)
    end
  end

  describe "#generate_capabilities" do
    include_context "create driver is stubbed"
    subject { under_test.generate_capabilities(config) }
    before do
      config.should_receive(:platform).and_return("platform")
      config.should_receive(:browser).and_return("browser")
      config.should_receive(:browser_version).and_return("version")
      config.should_receive(:record_screenshots).and_return("screens")
      config.should_receive(:record_video).and_return("video")
      config.should_receive(:idle_timeout).and_return("idle")
      config.should_receive(:max_duration).and_return("duration")
    end

    it { subject['platform'].should eq "platform" }
    it { subject['browserName'].should eq "browser" }
    it { subject['browser-version'].should eq "version" }
    it { subject['record-screenshots'].should eq "screens" }
    it { subject['record-video'].should eq "video" }
    it { subject['idle-timeout'].should eq "idle" }
    it { subject['max-duration'].should eq "duration" }
  end

  it_behaves_like "selenium driver" do
    include_context "create driver is stubbed"
  end

end
