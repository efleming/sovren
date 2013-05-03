module Sovren
  class Competency
    attr_accessor :name, :months, :last_used_date

    def self.parse(competencies)
      return Array.new if competencies.nil?
      results = competencies.css('Competency').collect do |item|
        c = Competency.new
        c.name = item['name']
        c.months = item.css('CompetencyEvidence NumericValue').text.to_i rescue nil
        c.last_used_date = Date.parse(item.css('CompetencyEvidence').first['lastUsed']) rescue nil
        c
      end
      results
    end

  end
end