require File.join(File.dirname(__FILE__), '../../jasmine-selenium-sauce')

begin
  config = Jasmine::Sauce::CI::SauceConfig.new
  config.validate
  Jasmine::Sauce::CI::Main.run_via_saucelabs(config)
rescue ArgumentError => e
  STDERR << "\nError: #{e.message}\n\n"
  STDERR << "The following environment variables are required:\n"
  STDERR << "\n"
  STDERR << "    SAUCELABS_URL - Your SauceLabs OnDemand URL with Basic Auth (http://username:password@ondemand.saucelabs.com:80/wd/hub)\n"
  STDERR << "    JASMINE_URL - Where your Jasmine tests are hosted (http://my.host.com:80/jasmine)\n"
  STDERR << "    SAUCE_BROWSER - Which Browser SauceLabs should use\n"
  STDERR << "\n"
  exit -1
rescue StandardError => e
  STDERR << "\nError: #{e.message}\n\n"
  if e.message.include?("jsApiReporter is not defined")
      STDERR << "Unable to find Jasmine tests, ensure server is running and #{config.jasmine_server_url} is correct\n\n"
  end
  exit -1
end
