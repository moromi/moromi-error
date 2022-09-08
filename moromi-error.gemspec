# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moromi/error/version'

Gem::Specification.new do |spec|
  spec.name          = "moromi-error"
  spec.version       = Moromi::Error::VERSION
  spec.authors       = ["Takahiro Ooishi"]
  spec.email         = ["taka0125@gmail.com"]

  spec.summary       = %q{Error templates}
  spec.description   = %q{Error templates}
  spec.homepage      = "https://github.com/moromi/moromi-error"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.6'

  spec.add_dependency 'rails', '>= 5.2'

  spec.add_development_dependency "jbuilder"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "sprockets-rails"
  spec.add_development_dependency "appraisal"
end
