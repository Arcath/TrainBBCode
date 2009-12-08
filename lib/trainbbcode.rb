class TBBC
	def initialize
		self.conf(:configed_by => "system")
	end
	def conf(config)
		config[:configed_by] ||= "user"
		config[:image_alt] ||= "Posted Image" 
		config[:url_target] ||= "_BLANK"
		config[:allow_defaults] ||= true
		#Instanize the config variable
		@config=config
	end
	def parse(s)
		#First off remove the < and > which will disable all HTML
		s=s.gsub("<","&lt;").gsub(">","&gt;")
		#Convert new lines to <br />'s
		s=s.gsub(/\n/,'<br />')
		#[nobbc] tags
		unless @config[:nobbc_enabled] == false
			s=nobbc s
		end
		#Loading Custom Tags
		if @config[:custom_tags] then
			@config[:custom_tags].each do |tag|
				s=s.gsub(tag[0],tag[1]) unless tag[2] == false
			end
		end
		#Loading Default Tags and applying them
		if @config[:allow_defaults] then
			tags=load_default_tags
			tags.each do |tag|
				s=s.gsub(tag[0],tag[1]) unless tag[2] == false
			end	
		end
		return s
	end
	def load_default_tags
		tags=[
			#Bold
			[/\[b\](.*?)\[\/b\]/,'<strong>\1</strong>',@config[:strong_enabled]],
			#Italic
			[/\[i\](.*?)\[\/i\]/,'<i>\1</i>',@config[:italic_enabled]],
			#Underline
			[/\[u\](.*?)\[\/u\]/,'<u>\1</u>',@config[:underline_enabled]],
			#Url
			[/\[url\](.*?)\[\/url\]/,'<a href="\1" target="' + @config[:url_target] +'">\1</a>',@config[:url_enabled]],
			[/\[url=(.*?)\](.*?)\[\/url\]/,'<a href="\1" target="' + @config[:url_target] + '">\2</a>',@config[:url_enabled]],
			#Image
			[/\[img\](.*?)\[\/img\]/,'<img src="\1" alt="'+ @config[:image_alt] + '" />',@config[:image_enabled]],
			[/\[img alt=(.*?)\](.*?)\[\/img\]/,'<img src="\2" alt="\1" />',@config[:image_enabled]],
			#Un-Ordered List
			[/\[ul\](.*?)\[\/ul\]/,'<ul>\1</ul>',@config[:list_enabled]],
			#Ordered List
			[/\[ol\](.*?)\[\/ol\]/,'<ol>\1</ol>',@config[:list_enabled]],
			#List Item
			[/\[li\](.*?)\[\/li\]/,'<li>\1</li>',@config[:list_enabled]]
		]
	end
	def nobbc(s)
		find=s.scan(/\[nobbc\](.*?)\[\/nobbc\]/)
		find.each do |f|
			replace=f[0].gsub("[","&#91;").gsub("]","&#93")
			s=s.gsub(f[0],replace)
		end
		s=s.gsub("[nobbc]","").gsub("[/nobbc]","")
		return s
	end
end

#Add .tbbc to Strings
class String
	def tbbc
		bbc=TBBC.new
		bbc.parse(self)
	end
end
