require 'bundler/setup'
require "sovren/version"
require 'savon'
require 'httpclient'
require 'nokogiri'

module Sovren
  class << self
    FIELDS = [:endpoint, :username, :password, :timeout, :hard_time_out_multiplier, :parser_configuration_params]
    attr_accessor(*FIELDS)

    def configure
      yield self
      true
    end
  end

  require_relative "sovren/achievement"
  require_relative "sovren/association"
  require_relative "sovren/certification"
  require_relative "sovren/client"
  require_relative "sovren/competency"
  require_relative "sovren/contact_information"
  require_relative "sovren/education"
  require_relative "sovren/employment"
  require_relative "sovren/resume"
  require_relative "sovren/language"
  require_relative "sovren/military"
  require_relative "sovren/patent"
  require_relative "sovren/publication"
  require_relative "sovren/reference"
end
