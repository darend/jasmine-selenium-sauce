require 'selenium-webdriver'
require 'json'

module Jasmine
  module Sauce
    module CI
      class SeleniumDriver

        def initialize(driver)
          @driver = driver
        end

        def connect(url)
          @driver.navigate.to url
        end

        def disconnect
          @driver.quit
        end

        def evaluate_js(script)
          result = @driver.execute_script(script)
          JSON.parse("{\"result\":#{result}}", :max_nesting => false)["result"]
        end
      end
    end
  end
end
