require 'jasmine-selenium-sauce/version'
require 'jasmine-selenium-sauce/jasmine_results'
require 'jasmine-selenium-sauce/rspec_reporter'
require 'jasmine-selenium-sauce/browser_config'
require 'jasmine-selenium-sauce/sauce_config'
require 'jasmine-selenium-sauce/selenium_runner'
require 'jasmine-selenium-sauce/drivers'
#require 'jasmine-selenium-sauce/drivers/selenium_browser_driver'
#require 'jasmine-selenium-sauce/drivers/selenium_saucelabs_driver'

module Jasmine
  module Sauce
    module CI

      class Main
        def self.run_via_saucelabs(sauce_config, reporter = RspecReporter.new)
          driver = SeleniumSauceLabsDriver.new(sauce_config)
          selenium_runner = SeleniumRunner.new(driver)
          results = selenium_runner.run(sauce_config.jasmine_server_url)
          reporter.report(results)
        end

        def self.run_via_browser(browser_config, reporter = RspecReporter.new)
          driver = SeleniumBrowserDriver.new(browser_config.browser)
          selenium_runner = SeleniumRunner.new(driver)
          results = selenium_runner.run(browser_config.jasmine_server_url)
          reporter.report(results)
        end
      end
    end
  end
end

require 'jasmine-selenium-sauce/tasks/railtie' if defined?(Rails)
