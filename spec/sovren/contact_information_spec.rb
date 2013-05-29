require 'spec_helper'

describe Sovren::ContactInformation do
  use_natural_assertions

  Given(:contact_information) { Sovren::ContactInformation.new }

  Then { contact_information.should respond_to :first_name }
  Then { contact_information.should respond_to :middle_name }
  Then { contact_information.should respond_to :last_name }
  Then { contact_information.should respond_to :generation }

  Then { contact_information.should respond_to :address_line_1 }
  Then { contact_information.should respond_to :address_line_2 }
  Then { contact_information.should respond_to :city }
  Then { contact_information.should respond_to :state }
  Then { contact_information.should respond_to :country }
  Then { contact_information.should respond_to :postal_code }

  Then { contact_information.should respond_to :home_phone }
  Then { contact_information.should respond_to :mobile_phone }

  Then { contact_information.should respond_to :email }
  Then { contact_information.should respond_to :website }

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/contact_information.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { Sovren::ContactInformation.parse(xml) }

      Then { result.first_name == "John" }
      Then { result.middle_name == "F." }
      Then { result.last_name == "Adams" }
      Then { result.generation == "III" }
      Then { result.aristocratic_title == "Duke" }
      Then { result.form_of_address == "Mr." }
      Then { result.qualification == "M.D." }

      Then { result.address_line_1 == "930 Via Mil Cumbres" }
      Then { result.address_line_2 == "Unit 119" }
      Then { result.city == "Solana Beach" }
      Then { result.state == "CA" }
      Then { result.postal_code == "92075" }
      Then { result.country == "US" }

      Then { result.home_phone == "(858) 555-1000" }
      Then { result.mobile_phone == "(858) 555-1001" }

      Then { result.website == "http://www.linkedin.com/in/johnadams" }
      Then { result.email == "johnadams@yamoo.com" }
    end  
    
    context "a sparse resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/contact_information_sparse.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { Sovren::ContactInformation.parse(xml) }

      Then { result.first_name == "John" }
      Then { result.last_name == "Adams" }
      Then { result.email == "johnadams@yamoo.com" }
    end  

    context "no contact info" do
      When(:result) { Sovren::ContactInformation.parse(nil) }

      Then { result == nil }
    end  
  end

end
