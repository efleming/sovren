module Sovren
  class Reference
    attr_accessor :name, :title, :email, :phone_number

    def self.parse(references)
      return Array.new if references.nil?
      result = references.css('Reference').collect do |item|
        r = Reference.new
        r.name = item.css('PersonName FormattedName').text
        r.title = item.css('PositionTitle').text
        r.email = item.css('ContactMethod InternetEmailAddress').first.text rescue nil
        r.phone_number = item.css('ContactMethod Telephone FormattedNumber').first.text rescue nil
        r
      end
      result
    end
  end
end