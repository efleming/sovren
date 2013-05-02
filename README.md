# Sovren

A simple ruby gem that parses a resume using the sovren resume parser and returns the resume back as a ruby object.

## Installation

Add this line to your application's Gemfile:

    gem 'sovren'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sovren

## Usage Example

1. Create a client

    ```ruby
    client = Sovren::Client.new(endpoint: "http://yourhost.com/SovrenConvertAndParse/ConvertAndParse.asmx?WSDL", username: "http basic username (optional)", password: "http basic password (optional)")
    ```

2. Parse a resume

    ```ruby
    resume = client.parse(File.read('/path/to/your/file/resume.doc'))
    ```

## Contributing

The testing could use some more coverage for other hr-xml use cases.  I also haven't added any of the sovren specific fields returned but those could be added if you need them.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
