# OpenApiComponentMeister

Generate and check Open API Component from your ActiveRecord model.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'open_api_component_meister'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install open_api_component_meister

## Basic Usage

Run command with specifying target model, and then you can get the result in standard output.
(In future, you will be able to specify model path or load every models to output.)

```shell
$ bundle exec oasc-meister User
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: integer
        name:
          type: string
        age:
          type: integer
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Issue/PR welcome !

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
