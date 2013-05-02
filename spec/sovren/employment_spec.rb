require 'spec_helper'

describe Sovren::Employment do
  use_natural_assertions

  context ".current_employer?" do
    When(:employment) {Sovren::Employment.new}
    Then { employment.current_employer? == false }
  end

  context ".parse" do
    context "a full resume" do
      Given(:raw_employment_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/employment.xml')) }
      Given(:employment_xml) { Nokogiri::XML.parse(raw_employment_xml) }

      When(:result) { Sovren::Employment.parse(employment_xml) }

      Then { result.length == 4 }
      Then { result.first.employer == "Technical Difference" }
      Then { result.first.division == nil }
      Then { result.first.title == "Director of Web Applications Development" }
      Then { result.first.city == "Encinitas"}
      Then { result.first.state == "CA"}
      Then { result.first.country == "US"}
      Then { result.first.description.length == 694 }
      Then { result.first.start_date == Date.new(2004,10,01) }
      Then { result.first.end_date == nil }
      Then { result.first.current_employer == true }
      Then { result.first.current_employer? == true }
    end
    
    context "a sparse resume" do
      Given(:raw_employment_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/employment_sparse.xml')) }
      Given(:employment_xml) { Nokogiri::XML.parse(raw_employment_xml) }

      When(:result) { Sovren::Employment.parse(employment_xml) }

      Then { result.length == 1 }
      Then { result.first.employer == "Technical Difference" }
      Then { result.first.title == "Director of Web Applications Development" }
      Then { result.first.current_employer? == false }
    end
  end

end