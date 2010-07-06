require 'trainbbcode/parse.rb'
require 'trainbbcode/tags.rb'
require 'trainbbcode/configure.rb'
require 'trainbbcode/string.rb'
require 'trainbbcode/css.rb'
require 'trainbbcode/swear_filter.rb'
require 'rubygems'
require 'coderay'

#Helper Method
require 'trainbbcode/application_helper.rb'
ActionView::Base.send :include, TBBCHelper

class TBBC
	# Creates a new TBBC class with everything set to default
	#
	# Also sets :configed_by to "system"
	def initialize
		self.conf(:configed_by => "system")
	end
	
	private
	
	def nobbc(s)
		find=s.scan(/\[nobbc\](.*?)\[\/nobbc\]/)
		find.each do |f|
			replace=f[0].gsub("[","&#91;").gsub("]","&#93")
			s=s.gsub("[nobbc]#{f[0]}[/nobbc]",replace)
		end
		return s
	end
	
	def correctbrs(s)
		#Corrects the extra brs
		s=s.gsub(/<br \/><(ul|li|table|tr|td|th)/,'<\1')
		s=s.gsub(/<br \/><\/(ul|li|table|tr|td|th)/,'</\1')
	end
	
	def coderay(input)	
		input=input.gsub("\r","")
		scan=input.scan(/\[code lang=(.+?)\](.+?)\[\/code\]/m)
		scan.each do |splits|
			parse=splits[1].gsub("&lt;","<").gsub("&gt;",">")
			lang=splits[0]
			parsed="[nobbc]" + CodeRay.scan(parse, lang).div(:css => :class, :line_numbers => @config[:syntax_highlighting_line_numbers]) + "[/nobbc]"
			input=input.gsub("[code lang=#{lang}]#{splits[1]}[/code]",parsed)
		end
		input
	end
	
end
