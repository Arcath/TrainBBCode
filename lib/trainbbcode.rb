class TBBC
	def initialize
		self.conf(:configed_by => "system")
	end
	def conf(config)
		require 'rubygems'
		#begin
		#	require 'uv'
			#UV Settings
		#	config[:syntax_output] ||= "HTML"
		#	config[:syntax_line_numbers] ||= true
		#	config[:syntax_theme] ||= "twilight"
		#rescue LoadError
		#	config[:syntax_highlighting]=false
		#end
		config[:configed_by] ||= "user"
		config[:image_alt] ||= "Posted Image" 
		config[:url_target] ||= "_BLANK"
		config[:allow_defaults] ||= true
		config[:table_width] ||= "100%"
		config[:syntax_theme] ||=
		#Instanize the config variable
		@config=config
	end
	def parse(s)
		#Run the UV Parser (if enabled) to sort out any code
		s=uv s unless @config[:syntax_highlighting] == false
		#Remove the < and > which will disable all HTML
		s=s.gsub("<","&lt;").gsub(">","&gt;") unless @config[:disable_html] == false
		#Convert new lines to <br />'s
		s=s.gsub(/\n/,'<br />') unless @config[:newline_enabled] == false
		#[nobbc] tags
		s=nobbc s unless @config[:nobbc_enabled] == false
		#Loading Custom Tags
		begin
			if @config[:custom_tags] then
				@config[:custom_tags].each do |tag|
					s=s.gsub(tag[0],tag[1]) unless tag[2] == false
				end
			end
		rescue
			s+="<br />Custom Tags failed to run"
		end
		#Loading Default Tags and applying them
		if @config[:allow_defaults] then
			tags=load_default_tags
			tags.each do |tag|
				s=s.gsub(tag[0],tag[1]) unless tag[2] == false
			end	
		end
		s=correctbrs s
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
			[/\[url=(.*?) target=(.*?)\](.*?)\[\/url\]/,'<a href="\1" target="\2">\3</a>',@config[:url_enabled]],
			#Image
			[/\[img\](.*?)\[\/img\]/,'<img src="\1" alt="'+ @config[:image_alt] + '" />',@config[:image_enabled]],
			[/\[img alt=(.*?)\](.*?)\[\/img\]/,'<img src="\2" alt="\1" />',@config[:image_enabled]],
			#Un-Ordered List
			[/\[ul\](.*?)\[\/ul\]/,'<ul>\1</ul>',@config[:list_enabled]],
			#Ordered List
			[/\[ol\](.*?)\[\/ol\]/,'<ol>\1</ol>',@config[:list_enabled]],
			#List Item
			[/\[li\](.*?)\[\/li\]/,'<li>\1</li>',@config[:list_enabled]],
			#Quote
			[/\[quote\](.*?)\[\/quote\]/,'<blockquote>\1</blockquote>',@config[:quote_enabled]],
			[/\[quote=(.*?)\](.*?)\[\/quote\]/,'<blockquote><i>Posted by <b>\1</b></i><br />\2</blockquote>',@config[:quote_enabled]],
			#Color
			[/\[color=(.*?)\](.*?)\[\/color\]/,'<span style="color:\1;">\2</span>',@config[:color_enabled]],
			#Alignment
			[/\[center\](.*?)\[\/center\]/,'<div style="text-align:center">\1</div>',@config[:alignment_enabled]],
			[/\[left\](.*?)\[\/left\]/,'<div style="text-align:left">\1</div>',@config[:alignment_enabled]],
			[/\[right\](.*?)\[\/right\]/,'<div style="text-align:right">\1</div>',@config[:alignment_enabled]],
			#Acronym
			[/\[acronym=(.*?)\](.*?)\[\/acronym\]/,'<acronym title="\1">\2</acronym>',@config[:acronym_enabled]],
			#Tables
			#Table Tag
			[/\[table\](.*?)\[\/table\]/,'<table width="' + @config[:table_width]+ '">\1</table>',@config[:table_enabled]],
			#Table Elements
			[/\[tr\](.*?)\[\/tr\]/,'<tr>\1</tr>',@config[:table_enabled]],
			[/\[td\](.*?)\[\/td\]/,'<td>\1</td>',@config[:table_enabled]],
			[/\[th\](.*?)\[\/th\]/,'<th>\1</th>',@config[:table_enabled]]
		]
	end
	def nobbc(s)
		find=s.scan(/\[nobbc\](.*?)\[\/nobbc\]/)
		find.each do |f|
			replace=f[0].gsub("[","&#91;").gsub("]","&#93")
			s=s.gsub("[nobbc]#{f[0]}[/nobbc]",replace)
		end
		return s
	end
	def css
		output="<style type=\"text/css\">
			blockquote{
				
			}
		</style>"
		output+=Uv.themes.map{|theme| %Q(<link rel="stylesheet" type="text/css" href="css/#{theme}.css" />\n)}
		return output
	end
	def uv(s)
		find=s.scan(/\[code lang=(.*?)\](.*?)\[\/code\]/)
		find.each do |f|
			#parse=nobbc "[nobbc]" + f[1] + "[/nobbc]"
			r=Uv.parse(f[1], @config[:syntax_output], f[0], @config[:syntax_line_numbers], @config[:syntax_theme])
		end
		s=s.gsub(/\[code lang=(.*?)\]/,'').gsub("[/code]",'')
		return s
	end
	def correctbrs(s)
		#Corrects the extra brs
		s=s.gsub(/<br \/><(ul|li|table|tr|td|th)/,'<\1')
		s=s.gsub(/<br \/><\/(ul|li|table|tr|td|th)/,'<\1')
	end
end

#Add .tbbc to Strings
class String
	def tbbc(conf = nil)
		bbc=TBBC.new
		bbc.conf(conf) if conf
		bbc.parse(self)
	end
end
