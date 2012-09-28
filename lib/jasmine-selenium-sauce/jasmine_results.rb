module Jasmine
  module Sauce
    module CI

      class JasmineResults
        attr_reader :suites

        def initialize(suites, suite_results)
          @suites = suites
          @suite_results = suite_results
        end

        def for_spec_id(id)
          @suite_results[id]
        end
      end
    end
  end
end
