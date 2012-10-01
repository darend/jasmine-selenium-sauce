# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jasmine-selenium-sauce/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Daren Desjardins"]
  gem.email         = ["darend@gmail.com"]
  gem.description   = %q{Rake tasks for running your Jasmine suite via a local browser or through SauceLabs}
  gem.summary       = %q{Rake tasks for running your Jasmine suite via a local browser or through SauceLabs. Can be used in your CI builds to enable running Jasmine suites}
  gem.homepage      = "https://github.com/darend/jasmine-selenium-sauce"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jasmine-selenium-sauce"
  gem.require_paths = ["lib"]
  gem.version       = Jasmine::Sauce::Ci::VERSION

  gem.add_development_dependency 'fakeweb'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'json_pure'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'vcr'

  gem.add_dependency 'localtunnel', "~> 0.3"
  gem.add_dependency 'rspec', ">= 2.0"
  gem.add_dependency 'selenium-webdriver', "> 2.0.0"
end
