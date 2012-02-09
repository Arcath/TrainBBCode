require 'trainbbcode/parse.rb'
require 'trainbbcode/tags.rb'
require 'trainbbcode/config.rb'
require 'trainbbcode/string.rb'
require 'trainbbcode/css.rb'
require 'trainbbcode/swear_filter.rb'
require 'trainbbcode/coderay'
require 'rubygems'
require 'coderay'

#Helper Method
if defined? Rails
	require 'trainbbcode/application_helper.rb'
	ActionView::Base.send :include, TBBCHelper
end

module TrainBBCode
    def self.configure
        @config = Config.new
        yield(@config) 
    end
    
    def self.configured?
       @config ? true : false 
    end
	
	def self.config
	    @config
    end
	
	private
	
	def self.nobbc(s)
		find=s.scan(/\[nobbc\](.*?)\[\/nobbc\]/)
		find.each do |f|
			replace=f[0].gsub("[","&#91;").gsub("]","&#93")
			s=s.gsub("[nobbc]#{f[0]}[/nobbc]",replace)
		end
		return s
	end
	
	def self.correctbrs(s)
		#Corrects the extra brs
		s=s.gsub(/<br \/><(ul|li|table|tr|td|th)/,'<\1')
		s=s.gsub(/<br \/><\/(ul|li|table|tr|td|th)/,'</\1')
	end

	def self.needs_html_safe?
		if defined? Rails
			return Rails.version =~ /^3\./
		else
			return false
		end
	end
end
