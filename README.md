# Envvar

Manages defining optional (and default) values, environment specific values and required values.
There is a focus on 12 Factor principle and definining most variables outside of the environment 
in production but making it easy for developers to get started with development environment 
specific variables and sensible defaults.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'envvar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install envvar

## Usage

Place the following lines as soon as possible in the application boot process:
```ruby
require 'envvar'
Envvar.load(File.expand_path('../application.yml', __FILE__))
```

The application.yml file contains a few different sections:
- required
- defaults
- development, test, etc.

A sample of this file is show below:
```yaml
required:
  - FOO
  - BAR
defaults:
  BAM: thud
development:
  FOO: bat
  BAR: qux
```

This gives a nice place to set application defaults and development/test variables in one place.  It would be best 
practise to not include the production environment variables in this file and instead set them as ENV variables in the 
outside environment.  Any variables listed in the `required` section that are not present in the ENV hash after the
Envvar.load call with raise `Envvar::EnvironmentError`.  This allows for a fast-fail setup which is useful in more
complex applications with quite a few necessary environment variables.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/envvar. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

