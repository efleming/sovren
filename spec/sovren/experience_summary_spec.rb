require 'spec_helper'

describe Sovren::ExperienceSummary do
  use_natural_assertions

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/experience_summary.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { Sovren::ExperienceSummary.parse(xml) }

      Then { result.years_of_work_experience == "13" }
      Then { result.months_of_work_experience == "159" }
      Then { result.description == "John F. Adams's experience appears to be concentrated in Information Technology / Database, with exposure to Sales / General. John F. Adams has 13 years of work experience, with 9 years of management experience, including a mid-level position." }
    end

    context "no experience_summary" do
      When(:result) { Sovren::ExperienceSummary.parse(nil) }

      Then { result == nil }
    end
  end

end
