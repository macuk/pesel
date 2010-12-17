# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "pesel"
  s.version     = Pesel::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Piotr Macuk"]
  s.email       = ["piotr@macuk.pl"]
  s.homepage    = "http://github.com/macuk/pesel"
  s.summary     = %q{PESEL validation and information}
  s.description = %q{Pesel class to check PESEL number and get information about its owner}

  s.rubyforge_project = "pesel"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
