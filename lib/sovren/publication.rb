module Sovren
  class Publication
    attr_accessor :type, :title, :role, :publication_date, :journal_or_serial_name, :volume, :issue, :page_number, :abstract, :copyright_date, :copyright_text, :edition, :isbn, :publisher_name, :publisher_location, :event_name, :conference_date, :conference_location, :comments, :number_of_pages

    def self.parse(publications)
      return Array.new if publications.nil?
      result = publications.css('Article,Book,ConferencePaper,OtherPublication').collect do |item|
        c = Publication.new
        c.type = item.name == "OtherPublication" ? item['type'] : item.name
        c.title = item.css('Title').text
        c.role = item.css('Name').first['role'] rescue nil
        c.publication_date = item.css('PublicationDate').css('YearMonth,Year').first.text rescue nil
        c.journal_or_serial_name = item.css('JournalOrSerialName').text
        c.volume = item.css('Volume').text
        c.issue = item.css('Issue').text
        c.page_number = item.css('PageNumber').text
        c.abstract = item.css('Abstract').text
        c.copyright_date = item.css('Copyright CopyrightDates OriginalDate Year, Copyright CopyrightDates OriginalDate YearMonth').first.text rescue nil
        c.copyright_text = item.css('Copyright CopyrightText').first.text rescue nil
        c.edition = item.css('Edition').text
        c.isbn = item.css('ISBN').text
        c.publisher_name = item.css('PublisherName').text
        c.publisher_location = item.css('PublisherLocation').text
        c.event_name = item.css('EventName').text
        c.conference_date = Date.parse(item.css('ConferenceDate AnyDate').text) rescue nil
        c.conference_location = item.css('ConferenceLocation').text
        c.comments = item.css('Comments').text
        c.number_of_pages = item.css('NumberOfPages').text.to_i rescue nil
        c
      end
      result
    end
  
  end
end
