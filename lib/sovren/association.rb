module Sovren
  class Association
    attr_accessor :name, :role

    def self.parse(associations)
      return nil if associations.nil?
      result = associations.css('Association').collect do |item|
        c = Association.new
        c.name = item.css('Name').first.text
        c.role = item.css('Role Name').text
        c
      end
      result
    end
  
  end
end