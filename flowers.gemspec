# -*- encoding: utf-8 -*-
require File.expand_path('../lib/flowers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = [ 'Chris Bielinski' ]
  gem.email         = [ 'chris@tilt9.com' ]
  gem.description   = %q{Order flowers through the Florist One API; nuff said.}
  gem.summary       = %q{Order flowers from Ruby!}
  gem.homepage      = 'https://github.com/chrisb/flowers'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.name          = 'flowers'
  gem.require_paths = [ 'lib' ]
  gem.version       = Flowers::VERSION

  gem.add_dependency 'savon', '~> 2.3'
  gem.add_dependency 'active_support', '>2'
end
