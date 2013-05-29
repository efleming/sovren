require 'spec_helper'

describe Sovren::Military do
  use_natural_assertions

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/military.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { Sovren::Military.parse(xml) }

      Then { result.country_served == "US" }
      Then { result.branch == "Army" }
      Then { result.rank_achieved == "FIRST LIEUTENANT" }
      Then { result.recognition_achieved == "Purple Heart" }
      Then { result.discharge_status == "Honorable" }
      Then { result.start_date == Date.new(1966,1,1) }
      Then { result.end_date == Date.new(1967,1,1) }
    end

    context "no military history" do
      When(:result) { Sovren::Military.parse(nil) }

      Then { result == nil }
    end
  end

end
