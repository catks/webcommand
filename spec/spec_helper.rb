require 'bundler/setup'
require 'rack/test'
require 'rspec-parameterized'
require 'byebug'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require 'webcommand'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include Rack::Test::Methods

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
