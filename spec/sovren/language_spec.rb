require 'spec_helper'

describe Sovren::Language do
  use_natural_assertions

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/languages.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { Sovren::Language.parse(xml) }

      Then { result.length == 3 }
      Then { result.first.language_code == "ps" }
      Then { result.first.read? == true }
      Then { result.first.speak? == true }
      Then { result.first.write? == true }
    end

    context "no languages" do
      When(:result) { Sovren::Language.parse(nil) }

      Then { result == Array.new }
    end
  end

end