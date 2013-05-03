module Sovren
  class Education
    attr_accessor :school_name, :city, :state, :country, :degree_name, :degree_type, :major, :minor, :gpa, :gpa_out_of, :start_date, :end_date, :graduated
    
    def self.parse(education_history)
      return Array.new if education_history.nil?
      result = education_history.css('SchoolOrInstitution').collect do |item|
        e = Education.new
        e.school_name = item.css('SchoolName').text
        e.city, e.state, e.country = item.css('PostalAddress Municipality, PostalAddress Region, PostalAddress CountryCode').collect(&:text)
        e.degree_type = item.css('Degree').first['degreeType']
        e.degree_name = item.css('Degree DegreeName').text
        e.major = item.css('DegreeMajor Name').text
        e.minor = item.css('DegreeMinor name').text
        e.gpa = item.css('EducationalMeasure MeasureValue StringValue').text.to_f rescue nil
        e.gpa_out_of = item.css('EducationalMeasure HighestPossibleValue StringValue').text.to_f rescue nil
        e.start_date = Date.parse(item.css('DatesOfAttendance StartDate AnyDate').text) rescue nil
        e.end_date = Date.parse(item.css('DatesOfAttendance EndDate AnyDate').text) rescue nil
        e.graduated = item.css('Degree DegreeDate AnyDate').text != ""
        e
      end
      result
    end
  
    def graduated?
      !graduated.nil? && graduated
    end  

  end
end