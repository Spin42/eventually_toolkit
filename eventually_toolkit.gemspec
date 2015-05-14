# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eventually_toolkit/version'

Gem::Specification.new do |spec|
  spec.name          = "eventually_toolkit"
  spec.version       = EventuallyToolkit::VERSION
  spec.authors       = ["Lo\xC3\xAFc Vigneron"]
  spec.email         = ["loic.vigneron@gmail.com"]
  spec.summary       = ""
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "sidekiq"
  spec.add_dependency "redis"
  spec.add_dependency "logging"
  spec.add_dependency "awesome_print"
end
