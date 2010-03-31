require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('trainbbcode','0.3.2') do |p|
	p.description	= "Provides BBCode for Ruby."
	p.url		= "http://www.arcath.net/pages/2"
	p.author	= "Adam \"Arcath\" Laycock"
	p.email		= "adam@arcath.net"
	p.ignore_pattern= ["tmp/*", "scripts/*"]
	p.development_dependencies	= []
	p.runtime_dependencies	= ["coderay"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
