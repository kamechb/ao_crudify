# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ao_crudify/version"

Gem::Specification.new do |s|

  s.name        = "ao_crudify"
  s.version     = AoCrudify::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["kame"]
  s.email       = ["kamechb@gmail.com"]
  s.homepage    = "http://github.com/kamechb/ao_crudify"

  s.summary     = %q{A dynamic resource controller for Rails > 2.3 and ActiveObject ORM that keeps your controllers nice and skinny.}
  s.description = %q{A dynamic resource controller for Rails > 2.3 and ActiveObject ORM that keeps your controllers nice and skinny.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency('rails', '>= 2.3.12')
  s.add_dependency('activeobject', '>= 0.3.4')
  s.add_dependency('rspec', '~> 1.3.0')
  s.add_dependency('rspec-rails', '~> 1.3.2')

end
