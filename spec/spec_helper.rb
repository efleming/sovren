require 'rubygems'
require 'bundler/setup'
require 'rspec/given'
require 'httpclient'
require 'vcr'
require 'sovren'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end