module Jasmine
  module Sauce
    module CI
      class SeleniumBrowserDriver < SeleniumDriver

        def initialize(browser)
          super(create_driver(browser))
        end

        def create_driver(browser)
          Selenium::WebDriver.for browser.to_sym
        end
      end
    end
  end
end
