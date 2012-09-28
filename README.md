# Jasmine::Sauce::Ci

Uses SauceLabs to connect to your server and run your Jasmine suites, producing an RSpec report

## Build Status [<img src="https://secure.travis-ci.org/darend/jasmine-selenium-sauce.png"/>](http://travis-ci.org/darend/jasmine-selenium-sauce)

## Installation

Add this line to your application's Gemfile:

    gem 'jasmine-selenium-sauce'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jasmine-selenium-sauce

## Usage

    rake jasmine:sauce

### Required Environment Variables

Requires the following environment variables to be set:

#### SAUCELABS_URL

URL for Saucelabs with your credentials included:

    SAUCELABS_URL=http://username:password@ondemand.saucelabs.com:80/wd/hub

#### JASMINE_URL

Where your Jasmine tests are hosted:

    JASMINE_URL=http://my.server.com/jasmine

#### SAUCE_BROWSER

Which browser SauceLabs should use to run your tests:

    SAUCE_BROWSER=chrome

### Optional Configuration

#### RSpec

You can specify the format of the RSpec report with:

    JASMINE_SPEC_FORMAT=documentation

#### Sauce Labs Configuration

See [sauce_config.rb](https://github.com/darend/jasmine-selenium-sauce/tree/master/lib/jasmine-selenium-sauce/sauce_config.rb)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
