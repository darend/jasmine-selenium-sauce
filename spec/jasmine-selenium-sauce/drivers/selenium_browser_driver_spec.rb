require 'spec_helper'
require 'selenium_driver'
require 'selenium_browser_driver'
require 'sample_results'
require 'selenium_driver_fixtures'

describe Jasmine::Sauce::CI::SeleniumBrowserDriver do

  let(:under_test) { Jasmine::Sauce::CI::SeleniumBrowserDriver.new(browser) }
  let(:browser) { "chrome" }
  let(:driver) { double("SeleniumWebDriver") }

  before do
    Selenium::WebDriver.should_receive(:for).with(browser.to_sym).and_return(driver)
  end

  describe "#create_driver" do
    subject { under_test }

    specify { expect {subject}.not_to raise_error }
  end

  it_behaves_like "selenium driver"

end
