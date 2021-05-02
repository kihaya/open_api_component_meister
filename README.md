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

```shell
$ bundle exec oasc-meister app/models/user.rb
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

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/open_api_component_meister.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
