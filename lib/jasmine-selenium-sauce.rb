require 'jasmine-selenium-sauce/version'
require 'jasmine-selenium-sauce/jasmine_results'
require 'jasmine-selenium-sauce/rspec_reporter'
require 'jasmine-selenium-sauce/sauce_config'
require 'jasmine-selenium-sauce/selenium_runner'
require 'jasmine-selenium-sauce/selenium_saucelabs_driver'

module Jasmine
  module Sauce
    module CI

      class Main
        def self.run(reporter = RspecReporter.new)
          config = SauceConfig.new
          config.validate
          driver = SeleniumSauceLabsDriver.new(config)
          selenium_runner = SeleniumRunner.new(driver)
          results = selenium_runner.run(config.jasmine_server_url)
          reporter.report(results)
        end
      end

    end
  end
end

require 'jasmine-selenium-sauce/tasks/railtie' if defined?(Rails)
