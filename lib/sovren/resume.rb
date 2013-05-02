require 'json'

module Sovren
  class Resume
    attr_accessor :executive_summary, :objective, :contact_information, :education_history, :employment_history, :certifications, :competencies, :achievements, :associations, :languages, :military_history, :patent_history, :publication_history, :references

    def self.parse(resume)
      parsed_resume = Nokogiri::XML.parse(resume)
      resume = self.new
      resume.executive_summary = parsed_resume.css('ExecutiveSummary').text
      resume.objective = parsed_resume.css('Objective').text
      resume.contact_information = ContactInformation.parse(parsed_resume.css('ContactInfo').first)
      resume.education_history = Education.parse(parsed_resume.css('EducationHistory').first)
      resume.employment_history = Employment.parse(parsed_resume.css('EmploymentHistory').first)
      resume.certifications = Certification.parse(parsed_resume.css('LicensesAndCertifications').first)
      resume.competencies = Competency.parse(parsed_resume.css('Qualifications').first)
      resume.achievements = Achievement.parse(parsed_resume.css('Achievements').first)
      resume.associations = Association.parse(parsed_resume.css('Associations').first)
      resume.languages = Language.parse(parsed_resume.css('Languages').first)
      resume.military_history = Military.parse(parsed_resume.css('MilitaryHistory').first)
      resume.patent_history = Patent.parse(parsed_resume.css('PatentHistory').first)
      resume.publication_history = Publication.parse(parsed_resume.css('PublicationHistory').first)
      resume.references = Reference.parse(parsed_resume.css('References').first)
      resume
    end

  end
end