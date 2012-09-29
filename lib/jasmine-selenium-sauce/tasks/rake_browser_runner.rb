require_relative '../../jasmine-selenium-sauce'

config = Jasmine::Sauce::CI::BrowserConfig.new
begin
  config.validate
  Jasmine::Sauce::CI::Main.run_via_browser(config)
rescue ArgumentError => e
  STDERR << "\nError: #{e.message}\n\n"
  STDERR << "The following environment variables are required:\n"
  STDERR << "\n"
  STDERR << "    JASMINE_URL - Where your Jasmine tests are hosted (http://my.host.com:80/jasmine)\n"
  STDERR << "    LOCAL_BROWSER - Which browser to run "
  STDERR << "(ie, internet_explorer, remote, chrome, firefox, ff, android, iphone, opera, safari)\n"
  STDERR << "\n"
  exit -1
rescue StandardError => e
  STDERR << "\nError: #{e.message}\n\n"
  if e.message.include?("jsApiReporter is not defined")
      STDERR << "Unable to find Jasmine tests, ensure server is running and #{config.jasmine_server_url} is correct\n\n"
  end
  exit -1
end
