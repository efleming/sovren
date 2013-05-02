module Sovren
  class Achievement
    attr_accessor :description

    def self.parse(achievements)
      return nil if achievements.nil?
      result = achievements.css('Achievement').collect do |item|
        c = Achievement.new
        c.description = item.css('Description').text
        c
      end
      result
    end
  
  end
end