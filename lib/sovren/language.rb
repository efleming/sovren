module Sovren
  class Language
    attr_accessor :language_code, :read, :write, :speak

    def self.parse(languages)
      return Array.new if languages.nil?
      result = languages.css('Language').collect do |item|
        c = Language.new
        c.language_code = item.css('LanguageCode').text
        c.read = item.css('Read').text == "true" rescue nil
        c.write = item.css('Write').text == "true" rescue nil
        c.speak = item.css('Speak').text == "true" rescue nil
        c
      end
      result
    end

    def read?
      !read.nil? && read
    end
  
    def write?
      !write.nil? && write
    end
  
    def speak?
      !speak.nil? && speak
    end
  
  end
end