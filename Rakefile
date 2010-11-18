require 'rubygems'
require 'rake'
require 'echoe'
require 'metric_fu'

Echoe.new('trainbbcode','1.0.1') do |p|
	p.description	= "Provides BBCode for Ruby."
	p.url		= "http://www.arcath.net/"
	p.author	= "Adam \"Arcath\" Laycock"
	p.email		= "adam@arcath.net"
	p.ignore_pattern= ["tmp/*", "scripts/*"]
	p.development_dependencies	= []
	p.runtime_dependencies	= ["coderay"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
