require 'spec_helper'

describe Sovren::Client do
  Given(:sovren_client) { Sovren::Client.new(endpoint: "foo1", account_id: "foo2", service_key: "foo3") }

  context 'init' do
    Then { sovren_client.should_not be_nil }
  end

  context '.config' do
    Then { sovren_client.should respond_to :endpoint }
    Then { sovren_client.endpoint == "foo1" }
    Then { sovren_client.should respond_to :account_id }
    Then { sovren_client.account_id == "foo2" }
    Then { sovren_client.should respond_to :service_key }
    Then { sovren_client.service_key == "foo3" }
  end

  describe 'parsing' do
    Given(:sovren_client) { Sovren::Client.new(endpoint: "http://www.foo.com/") }
    Given(:resume) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/ResumeSample.doc')) }

    context ".parse", vcr: {cassette_name: 'parsed_resume'} do
      When(:result) { sovren_client.parse(resume) }
      Then { result.class.should == Sovren::Resume }
    end
  end

end