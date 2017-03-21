# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'envvar/version'

Gem::Specification.new do |spec|
  spec.name          = "envvar"
  spec.version       = Envvar::VERSION
  spec.authors       = ["Brendan Stennett"]
  spec.email         = ["brendan@thinkdataworks.com"]

  spec.summary       = %q{Very simple library for managing configuration through ENV hash.}
  spec.description   = %q{Manages defining optional (and default) values, environment specific values and required values.  There is a focus on 12 Factor principle and definining most variables outside of the environment in production but making it easy for developers to get started with development environment specific variables and sensible defaults.}
  spec.homepage      = "http://github.com/HuffMoody/envvar"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
