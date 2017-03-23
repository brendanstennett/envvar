#!/usr/bin/env rake

require 'bundler/gem_helper'

namespace 'envvar' do
  Bundler::GemHelper.install_tasks name: 'envvar'
end

namespace 'envvar-rails' do
  class EnvvarRailsGemHelper < Bundler::GemHelper
    def tag_version; end # noop
  end

  EnvvarRailsGemHelper.install_tasks name: 'envvar-rails'
end

task build: %w(envvar:build envvar-rails:build)
task install: %w(envvar:install envvar-rails:install)
task release: %w(envvar:release envvar-rails:release)

require 'rspec/core/rake_task'

desc 'Run all specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(--color)
  t.verbose = false
end

task default: :spec
