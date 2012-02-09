# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "trainbbcode/version"

Gem::Specification.new do |s|
	s.name = "trainbbcode"
	s.version = TrainBBCode::VERSION
	s.platform = Gem::Platform::RUBY
	s.authors = ["Adam \"Arcath\" Laycock"]
	s.email = ["gems@arcath.net"]
	s.homepage = "http://trainbbcode.arcath.net"
	s.summary = "Provides BBCode for Ruby."
	
	s.add_development_dependency "rspec"
	s.add_dependency "coderay"
	
	s.files         = `git ls-files`.split("\n")
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
	s.require_paths = ["lib"]
end
