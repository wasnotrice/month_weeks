# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'month_weeks/version'

Gem::Specification.new do |spec|
  spec.name          = "month_weeks"
  spec.version       = MonthWeeks::VERSION
  spec.authors       = ["Eric Watson"]
  spec.email         = ["wasnotrice@gmail.com"]

  spec.summary       = "A tiny library for working with the weeks of a month"
  spec.homepage      = "https://github.com/wasnotrice/month_weeks"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
