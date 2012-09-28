require 'jasmine-sauce-ci/version'
require 'jasmine-sauce-ci/jasmine_results'
require 'jasmine-sauce-ci/rspec_reporter'
require 'jasmine-sauce-ci/sauce_config'
require 'jasmine-sauce-ci/selenium_runner'
require 'jasmine-sauce-ci/selenium_saucelabs_driver'

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

require 'jasmine-sauce-ci/tasks/railtie' if defined?(Rails)
