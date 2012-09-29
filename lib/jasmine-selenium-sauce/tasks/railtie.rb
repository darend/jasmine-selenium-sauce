require 'rails/railtie'

module Jasmine
  module Sauce
    module CI

      class Railtie < ::Rails::Railtie
        railtie_name :jasmine_sauce_ci

        rake_tasks do
          load "jasmine-selenium-sauce/tasks/jasmine_selenium_sauce.rake"
        end
      end

    end
  end
end