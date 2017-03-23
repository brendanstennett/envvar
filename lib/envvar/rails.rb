require 'envvar'

# Taken from the nicely put together gem "dotenv" that I have used in the past
# but doesn't functions a bit different than what I am looking for here.
# https://github.com/bkeepers/dotenv

# Fix for rspec rake tasks loading in development
#
# Dotenv loads environment variables when the Rails application is initialized.
# When running `rake`, the Rails application is initialized in development.
# Rails includes some hacks to set `RAILS_ENV=test` when running `rake test`,
# but rspec does not include the same hacks.
#
# See https://github.com/bkeepers/dotenv/issues/219
if defined?(Rake.application)
  is_running_specs = Rake.application.top_level_tasks.grep(/^spec(:|$)/).any?
  Rails.env = ENV['RAILS_ENV'] ||= 'test' if is_running_specs
end

module Envvar
  # Dotenv Railtie for using Dotenv to load environment from a file into
  # Rails applications
  class Railtie < Rails::Railtie
    # Public: Load dotenv
    #
    # This will get called during the `before_configuration` callback, but you
    # can manually call `Dotenv::Railtie.load` if you needed it sooner.
    def load
      Envvar.load(config_file, Rails.env)
    end

    # Internal: `Rails.root` is nil in Rails 4.1 before the application is
    # initialized, so this falls back to the `RAILS_ROOT` environment variable,
    # or the current working directory.
    def root
      Rails.root || Pathname.new(ENV['RAILS_ROOT'] || Dir.pwd)
    end

    # Rails uses `#method_missing` to delegate all class methods to the
    # instance, which means `Kernel#load` gets called here. We don't want that.
    def self.load
      instance.load
    end

    config.before_configuration { load }

    private

    def config_file
      root.join('config/application.yml')
    end
  end
end
