module Jasmine
  module Sauce
    module CI

      class BrowserConfig

        def validate
          raise ArgumentError.new("JASMINE_URL was not set") unless jasmine_server_url
          raise ArgumentError.new("LOCAL_BROWSER was not set") unless browser
        end

        def jasmine_server_url
          ENV['JASMINE_URL']
        end

        def browser
          ENV['LOCAL_BROWSER']
        end
      end
    end
  end
end