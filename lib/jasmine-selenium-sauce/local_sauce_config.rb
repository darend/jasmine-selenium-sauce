module Jasmine
  module Sauce
    module CI

      class LocalSauceConfig < SauceConfig

        def validate
          raise ArgumentError.new("SAUCELABS_URL was not set") unless saucelabs_server_url
          raise ArgumentError.new("JASMINE_PORT was not set") unless jasmine_server_port
          raise ArgumentError.new("SAUCE_BROWSER was not set") unless browser
        end

        def jasmine_server_port
          ENV['JASMINE_PORT']
        end

        def ssh_key_path
          ENV['SSH_KEY_PATH']
        end

        def ssh_key
          if !ssh_key_path.nil? && File.exists?(ssh_key_path)
            return File.read(ssh_key_path)
          else
            return nil
          end
        end
      end
    end
  end
end
