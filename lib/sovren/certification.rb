module Sovren
  class Certification
    attr_accessor :name, :description, :effective_date

    def self.parse(certifications)
      return Array.new if certifications.nil?
      result = certifications.css('LicenseOrCertification').collect do |item|
        c = Certification.new
        c.name = item.css('Name').text
        c.description = item.css('Description').text
        c.effective_date = Date.parse(item.css('EffectiveDate FirstIssuedDate AnyDate').text) rescue nil
        c
      end
      result
    end
  
  end
end