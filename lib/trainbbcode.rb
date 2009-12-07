class TBBC
	def initialize
		self.conf(:configed_by => "system")
	end
	def conf(config)
		config[:configed_by] ||= "user"
		config[:image_alt] ||= "Posted Image" 
		config[:url_target] ||= "_BLANK"
		
		@config=config
	end
	def parse(s)
		#First off remove the < and > which will disable all HTML
		s=s.gsub("<","&lt;").gsub(">","&gt;")
		#Convert new lines to <br />'s
		s=s.gsub(/\n/,'<br />')
		#Loading Custom Tags
		if @config[:custom_tags] then
			@config[:custom_tags].each do |tag|
				s=s.gsub(tag[0],tag[1]) unless tag[2] == false
			end
		end
		#Loading Default Tags and applying them
		tags=load_default_tags
		tags.each do |tag|
			s=s.gsub(tag[0],tag[1]) unless tag[2] == false
		end	
		
		return s
	end
	def load_default_tags
		tags=[
			[/\[b\](.*?)\[\/b\]/,'<strong>\1</strong>',@config[:strong_enabled]],
			[/\[i\](.*?)\[\/i\]/,'<i>\1</i>',@config[:italic_enabled]],
			[/\[u\](.*?)\[\/u\]/,'<u>\1</u>',@config[:underline_enabled]],
			[/\[url\](.*?)\[\/url\]/,'<a href="\1" target="' + @config[:url_target] +'">\1</a>',@config[:url_enabled]],
			[/\[url=(.*?)\](.*?)\[\/url\]/,'<a href="\1" target="' + @config[:url_target] + '">\2</a>',@config[:url_enabled]],
			[/\[img\](.*?)\[\/img\]/,'<img src="\1" alt="'+ @config[:image_alt] + '" />',@config[:image_enabled]],
			[/\[img alt=(.*?)\](.*?)\[\/img\]/,'<img src="\2" alt="\1" />',@config[:image_enabled]]
		]
	end
end

class String
	def tbbc
		bbc=TBBC.new
		bbc.parse(self)
	end
end
