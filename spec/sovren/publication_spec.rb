require 'spec_helper'

describe Sovren::Publication do
  use_natural_assertions

  When(:publication) { Sovren::Publication.new }

  Then { publication.should respond_to :type }
  Then { publication.should respond_to :title }
  Then { publication.should respond_to :role }
  Then { publication.should respond_to :publication_date }
  Then { publication.should respond_to :journal_or_serial_name }
  Then { publication.should respond_to :volume }
  Then { publication.should respond_to :issue }
  Then { publication.should respond_to :page_number }
  Then { publication.should respond_to :abstract }
  Then { publication.should respond_to :copyright_date }
  Then { publication.should respond_to :copyright_text }
  Then { publication.should respond_to :edition }
  Then { publication.should respond_to :isbn }
  Then { publication.should respond_to :publisher_name }
  Then { publication.should respond_to :publisher_location }
  Then { publication.should respond_to :event_name }
  Then { publication.should respond_to :conference_date }
  Then { publication.should respond_to :conference_location }
  Then { publication.should respond_to :comments }
  Then { publication.should respond_to :number_of_pages }

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/publications.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { Sovren::Publication.parse(xml) }

      Then { result.length == 4 }
      Then { result[0].type == "Article" }
      Then { result[1].type == "Book" }
      Then { result[2].type == "ConferencePaper" }
      Then { result[3].type == "Thesis" }

      Then { result.first.title == "Designing Interfaces for Youth Services Information Management" }
      Then { result.first.role == "author" }
      Then { result.first.publication_date == "1996-06" }
      Then { result.first.journal_or_serial_name == "1996 Human-Computer Interaction Laboratory Video Reports" }
      Then { result.first.volume == "2" }
      Then { result.first.issue == "3" }
      Then { result.first.page_number == "319-329" }
      Then { result[1].abstract == "A very readable introduction to XML." }
      Then { result[1].copyright_date == "2001" }
      Then { result[1].copyright_text == "Copyright 2nd edition" }
      Then { result[1].edition == "2nd Edition" }
      Then { result[1].isbn == "0596000222" }
      Then { result[1].publisher_name == "O'Malley Associates" }
      Then { result[1].publisher_location == "Garden City, NY, US" }
      Then { result[2].event_name == "SHRM 55th Annual Conference and Exposition" }
      Then { result[2].conference_date == Date.new(2003,06,10) }
      Then { result[2].conference_location == "Orlando, FL" }
      Then { result[3].comments == "Ph.D., University of California" }
      Then { result[3].number_of_pages == 158 }
    end

    context "no publications" do
      When(:result) { Sovren::Publication.parse(nil) }

      Then { result == Array.new }
    end
  end

end