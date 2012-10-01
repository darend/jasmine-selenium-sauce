require 'vcr'

# Parameters in 1.8.7 are not ordered like in 1.9, so we first
# check if the body's are the same and then fallback to comparing
# as JSON structures
json_body_matcher = lambda do |request_1, request_2|
  request_1.body == request_2.body || JSON.parse(request_1.body) == JSON.parse(request_2.body)
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :fakeweb
  config.default_cassette_options = {:match_requests_on => [:method, :uri, json_body_matcher], :record => :none}
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end
