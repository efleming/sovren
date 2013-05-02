require 'spec_helper'

describe Sovren::Client do
  Given(:sovren_client) { Sovren::Client.new(endpoint: "foo1", username: "foo2", password: "foo3") }

  context 'init' do
    Then { sovren_client.should_not be_nil }
  end

  context '.config' do
    Then { sovren_client.should respond_to :endpoint }
    Then { sovren_client.endpoint == "foo1" }
    Then { sovren_client.should respond_to :username }
    Then { sovren_client.username == "foo2" }
    Then { sovren_client.should respond_to :password }
    Then { sovren_client.password == "foo3" }
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