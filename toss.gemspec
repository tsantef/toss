# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "toss/version"

Gem::Specification.new do |s|
  s.name        = %q{toss}
  s.version     = Toss::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tim Santeford"]
  s.email       = ["tsantef@gmail.com"]
  s.homepage    = %q{https://github.com/tsantef/toss}
  s.default_executable = %q{toss}
  s.summary     = %q{toss - Simple deployment}
  s.description = %q{toss - Simple deployment}

  s.rubyforge_project = "toss"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency(%q<net-ssh>, [">= 2.0.14"])
  s.add_dependency(%q<net-scp>, [">= 1.0.0"])
  s.add_dependency(%q<highline>, [">= 0"])
  
end
