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
  config.expect_with :rspec do |c|
    c.syntax = :should
  end
end
