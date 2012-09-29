require_relative 'selenium_driver'

module Jasmine
  module Sauce
    module CI
      class SeleniumSauceLabsDriver < SeleniumDriver

        def initialize(sauce_config)
          @driver = create_driver(sauce_config)
        end

        def create_driver(sauce_config)
          timeout = sauce_config.selenium_client_timeout
          client = Selenium::WebDriver::Remote::Http::Default.new
          client.timeout = timeout
          options = {}
          options[:http_client] = client
          options[:url] = sauce_config.saucelabs_server_url
          options[:desired_capabilities] = generate_capabilities(sauce_config)
          Selenium::WebDriver.for :remote, options
        end

        def generate_capabilities(sauce_config)
          {
              'platform' => sauce_config.platform,
              'browserName' => sauce_config.browser,
              'browser-version' => sauce_config.browser_version,
              'record-screenshots' => sauce_config.record_screenshots,
              'record-video' => sauce_config.record_video,
              'idle-timeout' => sauce_config.idle_timeout,
              'max-duration' => sauce_config.max_duration,
              'name' => "Jasmine"
          }
        end
      end
    end
  end
end