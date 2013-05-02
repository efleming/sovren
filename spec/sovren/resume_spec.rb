require 'spec_helper'

describe Sovren::Resume do
  Given(:resume) { Sovren::Resume.new }

  Then { resume.should respond_to :executive_summary }
  Then { resume.should respond_to :objective }
  Then { resume.should respond_to :contact_information }
  Then { resume.should respond_to :education_history }
  Then { resume.should respond_to :employment_history }
  Then { resume.should respond_to :competencies }
  Then { resume.should respond_to :achievements }
  Then { resume.should respond_to :associations }
  Then { resume.should respond_to :certifications }
  Then { resume.should respond_to :languages }
  Then { resume.should respond_to :military_history }
  Then { resume.should respond_to :patent_history }
  Then { resume.should respond_to :publication_history }
  Then { resume.should respond_to :references }

  context '.parse' do
    use_natural_assertions
    Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/resume.xml')) }

    When(:result) { Sovren::Resume.parse(raw_xml) }

    Then { result.executive_summary.length == 119 }
    Then { result.objective.length == 84 }
    Then { result.contact_information.should_not be_nil }
    Then { result.education_history.length == 2 }
    Then { result.employment_history.length == 3 }
    Then { result.competencies.length == 54 }
    Then { result.achievements.length == 1 }
    Then { result.associations.length == 1 }
    Then { result.certifications.length == 4 }
    Then { result.languages.length == 3 }
    Then { result.military_history.class == Sovren::Military }
    Then { result.patent_history.length == 1 }
    Then { result.publication_history.length == 4 }
    Then { result.references.length == 1 }
  end
end