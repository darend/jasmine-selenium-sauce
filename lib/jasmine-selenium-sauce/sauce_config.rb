module Jasmine
  module Sauce
    module CI

      class SauceConfig

        def validate
          raise "You must set SAUCELABS_URL" unless saucelabs_server_url
          raise "You must set JASMINE_URL" unless jasmine_server_url
          raise "You must set SAUCE_BROWSER" unless browser
        end

        def saucelabs_server_url
          ENV['SAUCELABS_URL']
        end

        def jasmine_server_url
          ENV['JASMINE_URL']
        end

        def browser
          ENV['SAUCE_BROWSER']
        end

        def platform
           ENV['SAUCE_PLATFORM'] ? ENV['SAUCE_PLATFORM'].to_s.upcase.to_sym : :VISTA
        end

        def browser_version
          ENV['SAUCE_BROWSER_VERSION']
        end

        def record_screenshots
          ENV['SAUCE_SCREENSHOTS'] ? ENV['SAUCE_SCREENSHOTS'] : false
        end

        def record_video
           ENV['SAUCE_VIDEO'] ? ENV['SAUCE_VIDEO'] : false
        end

        def idle_timeout
           ENV['SAUCE_IDLE_TIMEOUT'] ? ENV['SAUCE_IDLE_TIMEOUT'] : 90
        end

        def max_duration
           ENV['SAUCE_MAX_DURATION'] ? ENV['SAUCE_MAX_DURATION'] : 180
        end

        def selenium_client_timeout
          ENV['SELENIUM_CLIENT_TIMEOUT'] ? ENV['SELENIUM_CLIENT_TIMEOUT'] : 120
        end
      end

    end
  end
end