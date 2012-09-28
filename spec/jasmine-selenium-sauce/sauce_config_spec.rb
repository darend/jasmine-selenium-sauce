require 'spec_helper'
require 'sauce_config'

describe Jasmine::Sauce::CI::SauceConfig do

  after do
    ENV.delete('SAUCELABS_URL')
    ENV.delete('JASMINE_URL')
    ENV.delete('SAUCE_BROWSER')
  end

  describe "#validate" do
    subject { Jasmine::Sauce::CI::SauceConfig.new.validate }

    context "when valid" do
      before do
        ENV['SAUCELABS_URL'] = 'sauce'
        ENV['JASMINE_URL'] = 'jasmine'
        ENV['SAUCE_BROWSER'] = 'browser'
      end
      specify { expect { subject }.not_to raise_error  }
    end

    context "when saucelabs url is not set" do
      before do
        ENV['JASMINE_URL'] = 'jasmine'
        ENV['SAUCE_BROWSER'] = 'browser'
      end
      specify { expect { subject }.to raise_error  }
    end

    context "when jasmine url is not set" do
      before do
        ENV['SAUCELABS_URL'] = 'sauce'
        ENV['SAUCE_BROWSER'] = 'browser'
      end
      specify { expect { subject }.to raise_error  }
    end

    context "when browser is not set" do
      before do
        ENV['SAUCELABS_URL'] = 'sauce'
        ENV['JASMINE_URL'] = 'jasmine'
      end
      specify { expect { subject }.to raise_error  }
    end
  end
  
  shared_examples_for "overridable configuration setting" do |env_setting, default|
    context "when not specified" do
      it { should eq(default) }
    end

    context "when specified" do
      let(:value) { "random value" }
      before { ENV[env_setting] = value }
      after { ENV.delete(env_setting) }
      it { should eq(value) }
    end
  end

  describe "#saucelabs_server_url" do
    let(:url) { "http://user:password@ondemand.saucelabs.com:80/wd/hub" }
    before { ENV['SAUCELABS_URL'] = url }
    after { ENV.delete('SAUCELABS_URL') }
    its(:saucelabs_server_url) { should eq(url)}
  end

  describe "#jasmine_server_url" do
    let(:url) { "http://my.host.com/jasmine" }
    before { ENV['JASMINE_URL'] = url }
    after { ENV.delete('JASMINE_URL') }
    its(:jasmine_server_url) { should eq(url)}
  end

  describe "#sauce_browser" do
    let(:browser) { "Chrome" }
    before { ENV['SAUCE_BROWSER'] = browser }
    after { ENV.delete('SAUCE_BROWSER') }
    its(:browser) { should eq(browser)}
  end

  describe "#sauce_platform" do
    context "when not specified" do
      its(:platform) { should eq(:VISTA) }
    end

    context "when specified" do
      let(:platform) { "WIN_7" }
      before { ENV['SAUCE_PLATFORM'] = platform }
      after { ENV.delete('SAUCE_PLATFORM') }
      its(:platform) { should eq(platform.to_sym) }
    end
  end

  describe "#browser_version" do
    subject { Jasmine::Sauce::CI::SauceConfig.new.browser_version }
    it_behaves_like "overridable configuration setting", 'SAUCE_BROWSER_VERSION', nil
  end

  describe "#record_screenshots" do
    subject { Jasmine::Sauce::CI::SauceConfig.new.record_screenshots }
    it_behaves_like "overridable configuration setting", 'SAUCE_SCREENSHOTS', false
  end

  describe "#record_video" do
    subject { Jasmine::Sauce::CI::SauceConfig.new.record_video }
    it_behaves_like "overridable configuration setting", 'SAUCE_VIDEO', false
  end

  describe "#idle_timeout" do
    subject { Jasmine::Sauce::CI::SauceConfig.new.idle_timeout }
    it_behaves_like "overridable configuration setting", 'SAUCE_IDLE_TIMEOUT', 90
  end

  describe "#max_duration" do
    subject { Jasmine::Sauce::CI::SauceConfig.new.max_duration }
    it_behaves_like "overridable configuration setting", 'SAUCE_MAX_DURATION', 180
  end
end