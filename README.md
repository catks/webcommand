# Webcommand

[![Build Status](https://travis-ci.org/catks/webcommand.svg?branch=master)](https://travis-ci.org/catks/webcommand)
[![Maintainability](https://api.codeclimate.com/v1/badges/c998fcc99367d0e26fca/maintainability)](https://codeclimate.com/github/catks/webcommand/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c998fcc99367d0e26fca/test_coverage)](https://codeclimate.com/github/catks/webcommand/test_coverage)


Webcommand lets you run commands through a Web API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'webcommand'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install webcommand

## Usage

Create a config file specifying the commands you want to expose with the permitted params.
```yaml
# my_config.yml
commands:
  hello_world:
  # Parameter without validations 
    command: 'echo "Hello {{world}}"' 
  hehe:
    command: 'echo "{{name}}, are you {{state}}"'
    params:
    # Validation can be configured with any REGEXP
      name: '^[a-zA-Z]+$'
      state: '^\S+$' 
```

Run the webserver with the cli (*OBS: See the `webcommand help server
` for additional options*):

`WEBCOMMAND_CONFIGURATION=./my_config.yml webcommand server --port 3000`

After that you can execute your commands throught the web api:

```sh
curl -X POST http://localhost:3000/executions \
-d '{"command": "hehe", "params": { "name": "Annie", "state": "Okay"} }' \
-H "Content-Type: application/json"

#=> {"stdout":"Annie, are you Okay\n","stderr":"","exit_status":0}%  
```

### With Rails

*...TODO...*

### With Docker

*...TODO...*

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/catks/webcommand.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
