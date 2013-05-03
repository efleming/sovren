require 'spec_helper'

describe Sovren::Patent do
  use_natural_assertions

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/patents.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { Sovren::Patent.parse(xml) }

      Then { result.length == 1 }
      Then { result.first.title == "Method and Apparatus for Removing Corn Kernels From Dentures" }
      Then { result.first.description == "George Doam and Neil Griffin, inventors, \"Method and Apparatus for Removing Corn Kernels From Dentures\", Patent 1,064,098." }
      Then { result.first.inventor_name == "George Doam and Neil Griffin" }
      Then { result.first.patent_id == "1064098" }
    end

    context "no patents" do
      When(:result) { Sovren::Patent.parse(nil) }

      Then { result == Array.new }
    end
  end

end