module Sovren
  class Client
    attr_reader :endpoint, :username, :password, :timeout, :hard_time_out_multiplier, :parser_configuration_params

    #Initialize the client class that will be used for all sovren requests.
    #
    #Certain requests will require an oauth token.  See http://developer.foursquare.com/docs/index_docs.html for the full list.
    #
    # @param [Hash] options
    # @option options String :endpoint The url that the web service is located at
    # @option options String :username The HTTP Basic auth username for the webservice
    # @option options String :password The HTTP Basic auth password for the webservice
    # @option options Integer :timeout The timeout for the parser
    # @option options Integer :hard_time_out_multiplier The hard timeout for the parser
    # @option options Integer :parser_configuration_params The parser configuration params, used to tweak the output of the parser

    def initialize(options={})
      @endpoint = options[:endpoint]
      @username = options[:username]
      @password = options[:password]
      @timeout = options[:timout] || 30000
      @hard_time_out_multiplier = options[:hard_time_out_multiplier] || 2     
      @parser_configuration_params = options[:parser_configuration_params] || "_100000_0_00000010_0000000110101100_1_0000000000000111111102000000000010000100000000000000"
    end

    def connection
      Savon.client(wsdl: endpoint, log: false)
    end

    def parse(file)
      result = connection.call(:parse) do |c|
        c.message({
          "DocumentAsByteArray" => Base64.encode64(file),
          "ParserConfigurationParams" => parser_configuration_params,
          "AlsoUseSovrenTaxonomy" => true,
          "EmbedConvertedTextInHrXml" => true,
          "HardTimeOutMultiplier" => hard_time_out_multiplier,
          "TimeOutInMs" => timeout})
      end

      Resume.parse(result.body[:parse_response][:parse_result])
    end

  end
end