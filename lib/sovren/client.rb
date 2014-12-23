module Sovren
  class Client
    attr_reader :endpoint, :account_id, :service_key, :configuration, :revision_date

    #Initialize the client class that will be used for all sovren requests.
    #
    # @param [Hash] options
    # @option options String :endpoint The url that the web service is located at
    # @option options String :account_id The account id for the webservice
    # @option options String :service_key The service key for the webservice
    # @option options Integer :configuration The parser configuration params, used to tweak the output of the parser
    # @option options String :revision_date The revision date of the resume in YYYY-MM-DD format. This is useful when parsing older resumes.

    def initialize(options={})
      @endpoint = options[:endpoint]
      @account_id = options[:account_id]
      @service_key = options[:service_key]
      @configuration = options[:configuration] || "_000000_0_00000001_1101010110001100_1_0000000000000111111102000000000010000100000000000000000000100"
      @revision_date = options[:revision_date]
    end

    def connection
      Savon.client(wsdl: endpoint, log: false)
    end

    def parse(file)
      result = connection.call(:parse_resume) do |c|
        c.message({
          "request" => {
            "AccountId"     => account_id,
            "ServiceKey"    => service_key,
            "FileBytes"     => Base64.encode64(file),
            "Configuration" => configuration,
            "RevisionDate"  => revision_date,
          }
        })
      end

      Resume.parse(result.body[:parse_resume_response][:parse_resume_result])
    end
  end
end