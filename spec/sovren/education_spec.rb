require 'spec_helper'

describe Sovren::Education do
  use_natural_assertions

  context ".graduated?" do
    When(:education) {Sovren::Education.new}
    Then { education.graduated? == false }
  end

  context ".parse" do
      context "a full list of experience" do
        Given(:raw_education_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/education.xml')) }
        Given(:education_xml) { Nokogiri::XML.parse(raw_education_xml) }

        When(:result) { Sovren::Education.parse(education_xml) }

        Then { result.length == 2 }
        Then { result.first.school_name == "California State University" }
        Then { result.first.city == "Chico"}
        Then { result.first.state == "CA"}
        Then { result.first.country == "US"}
        Then { result.first.major == "Business Administration" }
        Then { result.first.minor == "" }
        Then { result.first.degree_type == "bachelors" }
        Then { result.first.degree_name == "B.S." }
        Then { result.first.gpa == 3.66 }
        Then { result.first.gpa_out_of == 4.00 }
        Then { result.first.start_date == Date.new(1996,1,1) }
        Then { result.first.end_date == Date.new(1999,1,1) }
        Then { result.first.graduated == true }
        Then { result.first.graduated? == true }
      end
      
      context "very little experience information" do
        Given(:raw_education_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/education_sparse.xml')) }
        Given(:education_xml) { Nokogiri::XML.parse(raw_education_xml) }

        When(:result) { Sovren::Education.parse(education_xml) }

        Then { result.length == 1 }
        Then { result.first.school_name == "California State University" }
        Then { result.first.degree_type == "bachelors" }
        Then { result.first.degree_name == "B.S." }
      end
  end

end