require 'jasmine-selenium-sauce/version'
require 'jasmine-selenium-sauce/jasmine_results'
require 'jasmine-selenium-sauce/rspec_reporter'
require 'jasmine-selenium-sauce/browser_config'
require 'jasmine-selenium-sauce/sauce_config'
require 'jasmine-selenium-sauce/local_sauce_config'
require 'jasmine-selenium-sauce/selenium_runner'
require 'jasmine-selenium-sauce/drivers/selenium_driver'
require 'jasmine-selenium-sauce/drivers/selenium_browser_driver'
require 'jasmine-selenium-sauce/drivers/selenium_saucelabs_driver'

require 'localtunnel/tunnel'
require 'localtunnel_patch'

module Jasmine
  module Sauce
    module CI

      class Main
        def self.run_via_saucelabs(sauce_config, reporter = RspecReporter.new)
          puts "Using SauceLabs to run Jasmine suite located at #{sauce_config.jasmine_server_url}"
          driver = SeleniumSauceLabsDriver.new(sauce_config)
          selenium_runner = SeleniumRunner.new(driver)
          results = selenium_runner.run(sauce_config.jasmine_server_url)
          reporter.report(results)
        end

        def self.run_local_via_saucelabs(local_sauce_config, reporter = RspecReporter.new)
          puts "Establishing tunnel to port #{local_sauce_config.jasmine_server_port}"
          tunnel = LocalTunnel::Tunnel.new(local_sauce_config.jasmine_server_port,local_sauce_config.ssh_key)
          response = tunnel.register_tunnel
          tunnel.start_tunnel do
            ENV['JASMINE_URL'] = "http://#{response['host']}/jasmine"
            run_via_saucelabs(local_sauce_config, reporter)
          end
        end

        def self.run_via_browser(browser_config, reporter = RspecReporter.new)
          puts "Running Jasmine suite against #{browser_config.jasmine_server_url} using #{browser_config.browser}"
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
