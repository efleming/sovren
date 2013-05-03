require 'spec_helper'

describe Sovren::Certification do
  use_natural_assertions

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/certifications.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { Sovren::Certification.parse(xml) }

      Then { result.length == 4 }
      Then { result[2].name == "Sun Secure Global Desktop (Tarantella) System Administration" }
      Then { result[2].description == "certification" }
      Then { result[2].effective_date == Date.new(2001,9,1) }
    end

    context "no competencies" do
      When(:result) { Sovren::Certification.parse(nil) }

      Then { result == Array.new }
    end
  end

end
