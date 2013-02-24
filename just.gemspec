# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'just/version'

Gem::Specification.new do |gem|
  gem.name          = "just"
  gem.version       = Just::VERSION
  gem.authors       = ["Paul Campbell"]
  gem.email         = ["paul@rslw.com"]
  gem.description   = %q{A simple web framework. Just Ruby.}
  gem.summary       = %q{A simple web framework that doesn't do much magic.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
