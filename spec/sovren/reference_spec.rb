require 'spec_helper'

describe Sovren::Reference do
  use_natural_assertions

  When(:reference) { Sovren::Reference.new }

  Then { reference.should respond_to :name }
  Then { reference.should respond_to :title }
  Then { reference.should respond_to :email }
  Then { reference.should respond_to :phone_number }

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/references.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { Sovren::Reference.parse(xml) }

      Then { result.length == 1 }
      Then { result.first.name == "Babs Smith" }
      Then { result.first.title == "Manager" }
      Then { result.first.email == "babs@somers.com" }
      Then { result.first.phone_number == "845-876-0988" }
    end

    context "no references" do
      When(:result) { Sovren::Reference.parse(nil) }

      Then { result == Array.new }
    end
  end

end