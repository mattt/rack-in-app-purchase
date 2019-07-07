# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'rack/in-app-purchase/version'

Gem::Specification.new do |s|
  s.name        = 'rack-in-app-purchase'
  s.authors     = ['Mattt']
  s.email       = 'mattt@me.com'
  s.license     = 'MIT'
  s.homepage    = 'https://mat.tt'
  s.version     = Rack::InAppPurchase::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'Rack::InAppPurchase'
  s.description = 'Rack middleware for in-app purchase receipt verification and product listing.'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.add_dependency 'rack', '~> 1.4', '< 2.0.0'
  s.add_dependency 'sequel', '~> 3.37'
  s.add_dependency 'sinatra', '~> 1.3'
  s.add_dependency 'venice'

  s.files         = Dir['./**/*'].reject { |file| file =~ %r{\./(bin|example|log|pkg|script|spec|test|vendor)} }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
