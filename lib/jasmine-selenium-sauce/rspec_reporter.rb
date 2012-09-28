require 'enumerator'
require 'rspec'

#
# Reused from https://github.com/pivotal/jasmine-gem
#

module Jasmine
  module Sauce
    module CI
      class RspecReporter

        def report(results)
          @results = results
          declare_suites(@results.suites)
        end

        def declare_suites(suites)
          suites.each do |suite|
            group = example_group(suite["name"]) {}
            process_children(group, suite["children"])
          end
        end

        def process_children(parent, children)
          children.each do |suite_or_spec|
            type = suite_or_spec["type"]
            if type == "suite"
              process_children(parent.describe(suite_or_spec["name"]), suite_or_spec["children"])
            elsif type == "spec"
              declare_spec(parent, suite_or_spec)
            else
              raise "unknown type #{type} for #{suite_or_spec.inspect}"
            end
          end
        end

        def declare_spec(parent, spec)
          me = self
          example_name = spec["name"]
          parent.it example_name, {} do
            me.report_spec(spec["id"])
          end
        end

        def report_spec(spec_id)
          spec_results = results_for(spec_id)
          out = ""
          messages = spec_results['messages'].each do |message|
            case
            when message["type"] == "log"
              puts message["text"]
              puts "\n"
            else
              unless message["message"] =~ /^Passed.$/
                STDERR << message["message"]
                STDERR << "\n"

                out << message["message"]
                out << "\n"
              end

              if !message["passed"] && message["trace"]["stack"]
                stack_trace = message["trace"]["stack"].gsub(/<br \/>/, "\n").gsub(/<\/?b>/, " ")
                STDERR << stack_trace.gsub(/\(.*\)@http:\/\/localhost:[0-9]+\/specs\//, "/spec/")
                STDERR << "\n"
              end
            end

          end
          fail out unless spec_results['result'] == 'passed'
          puts out unless out.empty?
        end

        private

        def example_group(*args, &block)
          RSpec::Core::ExampleGroup.describe(*args, &block).register
        end

        def results_for(spec_id)
          @results.for_spec_id(spec_id.to_s)
        end
      end
    end
  end
end
