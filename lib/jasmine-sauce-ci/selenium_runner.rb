require 'json'

module Jasmine
  module Sauce
    module CI
      class SeleniumRunner

        def initialize(driver, result_batch_size = 500)
          @driver = driver
          @result_batch_size = result_batch_size
        end

        def run(jasmine_url)
          @driver.connect jasmine_url
          wait_for_jasmine_to_load(load_jasmine_timeout)
          suites = fetch_suites
          wait_for_jasmine_to_finish(jasmine_execution_timeout)
          suite_results = fetch_suite_results(suites)
          @driver.disconnect
          Jasmine::Sauce::CI::JasmineResults.new(suites, suite_results)
        end

        private

        def load_jasmine_timeout
          60
        end

        def wait_for_jasmine_to_load(timeout)
          started = Time.now
          while !evaluate_js('return jsApiReporter && jsApiReporter.started') do
            raise "Timed out after #{timeout}s waiting for Jasmine to load" if (started + timeout < Time.now)
            sleep 0.1
          end
        end

        def fetch_suites
          evaluate_js("var result = jsApiReporter.suites(); if (window.Prototype && Object.toJSON) { return Object.toJSON(result) } else { return JSON.stringify(result) }")
        end

        def jasmine_execution_timeout
          300
        end

        def wait_for_jasmine_to_finish(timeout)
          started = Time.now
          while !evaluate_js('return jsApiReporter.finished') do
            raise "Timed out after #{timeout}s waiting for Jasmine to finish" if (started + timeout < Time.now)
            sleep 0.1
          end
        end

        def fetch_suite_results(suites)
          spec_results = {}
          extract_spec_ids(suites).each_slice(@result_batch_size) do |slice|
            slice_results = evaluate_js("var result = jsApiReporter.resultsForSpecs(#{json_generate(slice)}); if (window.Prototype && Object.toJSON) { return Object.toJSON(result) } else { return JSON.stringify(result) }")
            spec_results.merge!(slice_results)
          end
          spec_results
        end

        def extract_spec_ids(suites)
          map_spec_ids = lambda do |suites|
            suites.map do |suite_or_spec|
              if suite_or_spec['type'] == 'spec'
                suite_or_spec['id']
              else
                map_spec_ids.call(suite_or_spec['children'])
              end
            end
          end
          map_spec_ids.call(suites).compact.flatten
        end

        def evaluate_js(script)
          @driver.evaluate_js(script)
        end

        def json_generate(obj)
          JSON.generate(obj)
        end
      end
    end
  end
end
