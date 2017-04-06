module Sovren
  class ExperienceSummary
    attr_accessor :months_of_work_experience, :years_of_work_experience, :description

    def self.parse(experience_summary)
      return nil if experience_summary.nil?
      e = ExperienceSummary.new
      e.months_of_work_experience = experience_summary.css('sov|MonthsOfWorkExperience').text
      e.years_of_work_experience = experience_summary.css('sov|YearsOfWorkExperience').text
      e.description = experience_summary.css('sov|Description').text
      e
    end
  end
end
