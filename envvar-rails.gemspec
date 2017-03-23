# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'envvar/version'

Gem::Specification.new do |spec|
  spec.name    = 'envvar-rails'
  spec.version = Envvar::VERSION
  spec.authors = ['Brendan Stennett']
  spec.email   = ['brendan@thinkdataworks.com']

  spec.summary     = %q{Rails integration for envvar}
  spec.description = spec.summary
  spec.homepage    = 'http://github.com/HuffMoody/envvar'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files lib | grep rails`.split(
      $OUTPUT_RECORD_SEPARATOR
  ) + ["README.md", "LICENSE"]
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'envvar', Envvar::VERSION
  spec.add_dependency 'railties', '>= 3.2', '< 5.1'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
