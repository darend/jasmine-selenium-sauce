# Jasmine::Sauce::Ci

Uses SauceLabs to connect to your server and run your Jasmine suites, producing an RSpec report

## Installation

Add this line to your application's Gemfile:

    gem 'jasmine-selenium-sauce'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jasmine-selenium-sauce

## Usage

Requires the following environment variables to be set:

### SAUCELABS_URL

URL for Saucelabs with your credentials included:

    SAUCELABS_URL=http://username:password@ondemand.saucelabs.com:80/wd/hub

### JASMINE_URL

Where your Jasmine tests are hosted:

    JASMINE_URL=http://my.server.com/jasmine

### SAUCE_BROWSER

Which browser SauceLabs should use to run your tests:

    SAUCE_BROWSER=chrome

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
