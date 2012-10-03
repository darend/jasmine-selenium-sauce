## Build Status [<img src="https://secure.travis-ci.org/darend/jasmine-selenium-sauce.png"/>](http://travis-ci.org/darend/jasmine-selenium-sauce)

# Jasmine::Sauce::Ci

Rake tasks for running your Jasmine suite via a local browser or through SauceLabs using the
[Selenium Webdriver](http://seleniumhq.org/projects/webdriver/).

Can be used in your CI builds to enable running Jasmine suites. The Jasmine results are reported using RSpec to make
parsing easy.

# Requirements

Only requires that you have Jasmine available as a route in your application for testing. Recommend using [Jasminerice](https://github.com/bradphelan/jasminerice)

# Installation

Add this line to your application's Gemfile:

    gem 'jasmine-selenium-sauce'

# Running Jasmine via SauceLabs

## Remote Jasmine Server

When you want to run a Jasmine suite hosted on a publicly available host. Uses Selenium to connect to SauceLabs, and 
requests a browser instance to run your suite.

    rake jasmine:sauce

### Required Environment Variables

Requires the following environment variables to be set:

```shell
SAUCELABS_URL=http://username:password@ondemand.saucelabs.com:80/wd/hub
```
- URL for Saucelabs with your credentials included

```shell
JASMINE_URL=http://my.server.com/jasmine
```
- Where your Jasmine tests are hosted

```shell
SAUCE_BROWSER=chrome
```
- Which browser SauceLabs should use to run your tests

## Local Jasmine Server behind a Firewall

When you want to run a Jasmine suite hosted on an internal host. Uses [LocalTunnel](http://progrium.com/localtunnel/)
to make localhost available through a tunnel. It then uses Selenium to connect to SauceLabs, and requests a 
browser instance to run your suite.

    rake jasmine:local_sauce

### Required Environment Variables

Requires the following environment variables to be set:

```shell
SAUCELABS_URL=http://username:password@ondemand.saucelabs.com:80/wd/hub
```
- URL for Saucelabs with your credentials included

```shell
JASMINE_PORT=3000
```
- Port on localhost where jasmine tests are located

```shell
SAUCE_BROWSER=chrome
```
- Which browser SauceLabs should use to run your tests

## Optional Configuration

### RSpec

```shell
JASMINE_SPEC_FORMAT=documentation
```
- Allows you to control the format of the RSpec report

### Additional Sauce Labs Configuration

See [sauce_config.rb](https://github.com/darend/jasmine-selenium-sauce/tree/master/lib/jasmine-selenium-sauce/sauce_config.rb)

# Running Jasmine via local browser

    rake jasmine:browser

## Required Environment Variables

Requires the following environment variables to be set:

```shell
JASMINE_URL=http://my.server.com/jasmine
```
- Where your Jasmine tests are hosted

```shell
LOCAL_BROWSER=firefox
```
- Which browser that will be used to run your tests. Selenium may require a driver be installed depending the driver. See
the Selenium documentation for more details
See [Which browsers does WebDriver support?](http://code.google.com/p/selenium/wiki/FrequentlyAskedQuestions#Q:_Which_browsers_does_WebDriver_support?).

## Optional Configuration

### RSpec

```shell
JASMINE_SPEC_FORMAT=documentation
```
- Allows you to control the format of the RSpec report

# Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
