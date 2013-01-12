# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'varfile/version'

Gem::Specification.new do |gem|
  gem.name          = "varfile"
  gem.version       = Varfile::VERSION
  gem.authors       = ["Fabrizio Regini"]
  gem.email         = ["freegenie@gmail.com"]
  gem.description   = %q{writes and reads key=value from file}
  gem.summary       = %q{writes and reads key=value from file}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "thor", "~> 0.16.0"

end
