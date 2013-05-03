require 'spec_helper'

describe Sovren::Association do
  use_natural_assertions

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/associations.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { Sovren::Association.parse(xml) }

      Then { result.length == 1 }
      Then { result.first.name == "Association of Retired Military Document Examiners" }
      Then { result.first.role == "Member" }
    end

    context "no associations" do
      When(:result) { Sovren::Association.parse(nil) }

      Then { result == Array.new }
    end
  end

end