require_relative '../../jasmine-selenium-sauce'
#require_relative '../../jasmine-selenium-sauce/sauce_config'

begin
  config = Jasmine::Sauce::CI::SauceConfig.new
  config.validate
  Jasmine::Sauce::CI::Main.run(config)
rescue ArgumentError => e
  STDERR << "\nError: #{e.message}\n\n"
  STDERR << "The following environment variables are required:\n"
  STDERR << "\n"
  STDERR << "    SAUCELABS_URL - Your SauceLabs OnDemand URL with Basic Auth\n"
  STDERR << "    JASMINE_URL - Where your Jasmine tests are hosted\n"
  STDERR << "    SAUCE_BROWSER - Which Browser SauceLabs should use\n"
  STDERR << "\n"
  exit -1
end
