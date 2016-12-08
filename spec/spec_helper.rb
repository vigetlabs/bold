Bundler.require(:test)

require "bold"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

VCR.configure do |config|
  config.hook_into :webmock
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.ignore_localhost     = true
end
