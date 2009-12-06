require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('trainbbcode','0.1.0') do |p|
	p.description	= "Provides BBCode"
	p.url		= "http://github.com/Arcath/TrainBBCode"
	p.author	= "Adam \"Arcath\" Laycock"
	p.email		= "adam@arcath.net"
	p.ignore_pattern= ["tmp/*", "scripts/*"]
	p.development_dependencies	= []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
