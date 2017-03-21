require "envvar/version"
require "erb"
require "yaml"

module Envvar
  class EnvironmentError < StandardError; end

  DEFAULTS_KEY = 'defaults'
  REQUIRED_KEY = 'required'

  def self.load(file_path, env = (ENV['RACK_ENV'] || :development))
    config = YAML.load(ERB.new(open(file_path).read).result)

    set_environment(config, env.to_s)
    set_defaults(config)

    check_required(config)
  end

  private

  def self.set_defaults(config)
    return if config[DEFAULTS_KEY].nil?

    set_from_hash(config[DEFAULTS_KEY])
  end

  def self.set_environment(config, env)
    return if config[env].nil?

    set_from_hash(config[env])
  end

  def self.check_required(config)
    return if config[REQUIRED_KEY].nil?

    check_from_hash(config[REQUIRED_KEY])
  end

  def self.set_from_hash(config)
    config.each do |var, default|
      if ENV[var].nil?
        ENV[var] = default.to_s
      end
    end
  end

  def self.check_from_hash(config)
    config.each do |var|
      if ENV[var].nil?
        raise EnvironmentError.new("Required var #{var} not found in ENV hash")
      end
    end
  end
end
