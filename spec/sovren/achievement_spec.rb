require 'spec_helper'

describe Sovren::Achievement do
  use_natural_assertions

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/achievements.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { Sovren::Achievement.parse(xml) }

      Then { result.length == 1 }
      Then { result.first.description == "Awarded Medal of Merit by the Royal Society of Forensics, 2005" }
    end

    context "no achievements" do
      When(:result) { Sovren::Achievement.parse(nil) }

      Then { result == Array.new }
    end
  end

end