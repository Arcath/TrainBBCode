class TBBC
	#TrainBBCode
	#BBCode for Train
	def initialize
		self.conf(:configed_by => "system")
	end
	def conf(config)
		require 'rubygems'
		require 'coderay'
		config[:configed_by]			||= "user"
		config[:image_alt]			||= "Posted Image" 
		config[:url_target]			||= "_BLANK"
		config[:allow_defaults]			||= true
		config[:table_width]			||= "100%"
		config[:syntax_highlighting]		||= true
		config[:syntax_highlighting_html]	||= "color:#E7BE69"
		config[:syntax_highlighting_comment]	||= "color:#BC9358; font-style: italic;"
		config[:syntax_highlighting_escaped]	||= "color:#509E4F"
		config[:syntax_highlighting_class]	||= "color:#FFF"
		config[:syntax_highlighting_constant]	||= "color:#FFF"
		config[:syntax_highlighting_float]	||= "color:#A4C260"
		config[:syntax_highlighting_function]	||= "color:#FFC56D"
		config[:syntax_highlighting_global]	||= "color:#D0CFFE"
		config[:syntax_highlighting_integer]	||= "color:#A4C260"
		config[:syntax_highlighting_inline]	||= "background:#151515"
		config[:syntax_highlighting_instance]	||= "color:#D0CFFE"
		config[:syntax_highlighting_doctype]	||= "color:#E7BE69"
		config[:syntax_highlighting_keyword]	||= "color:#CB7832"
		config[:syntax_highlighting_regex]	||= "color:#A4C260"
		config[:syntax_highlighting_string]	||= "color:#A4C260"
		config[:syntax_highlighting_symbol]	||= "color:#6C9CBD"
		config[:syntax_highlighting_html]	||= "color:#E7BE69"
		config[:syntax_highlighting_boolean]	||= "color:#6C9CBD"
		config[:syntax_highlighting_line_numbers]||= :inline
		#Instanize the config variable
		@config=config
	end
	def parse(input)
		#Remove the < and > which will disable all HTML
		input=input.gsub("<","&lt;").gsub(">","&gt;") unless @config[:disable_html] == false
		#CodeRay
		input=coderay(input) unless @config[:syntax_highlighting] == false
		#Convert new lines to <br />'s
		input=input.gsub(/\n/,'<br />') unless @config[:newline_enabled] == false
		#[nobbc] tags
		input=nobbc input unless @config[:nobbc_enabled] == false
		#Loading Custom Tags
		begin
			if @config[:custom_tags] then
				@config[:custom_tags].each do |tag|
					input=runtag(input,tag)
				end
			end
		rescue
			input+="<br />Custom Tags failed to run"
		end
		#Loading Default Tags and applying them
		if @config[:allow_defaults] then
			load_default_tags.each do |tag|
				input=runtag(input,tag)
			end	
		end
		input=correctbrs input
		return input
	end
	def runtag(s,tag)
		s.gsub(tag[0],tag[1]) unless tag[2] == false
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
			.CodeRay {
				background-color: #232323;
				border: 1px solid black;
				font-family: 'Courier New', 'Terminal', monospace;
				color: #E6E0DB;
				padding: 3px 5px;
				overflow: auto;
				font-size: 12px;
				margin: 12px 0;
			}
			.CodeRay pre {
				margin: 0px;
				padding: 0px;
			}

			.CodeRay .an { #{@config[:syntax_highlighting_html]} }		/* html attribute */
			.CodeRay .c  { #{@config[:syntax_highlighting_comment]} }	/* comment */
			.CodeRay .ch { #{@config[:syntax_highlighting_escaped]} }	/* escaped character */
			.CodeRay .cl { #{@config[:syntax_highlighting_class]} }		/* class */
			.CodeRay .co { #{@config[:syntax_highlighting_constant]} }	/* constant */
			.CodeRay .fl { #{@config[:syntax_highlighting_float]} }		/* float */
			.CodeRay .fu { #{@config[:syntax_highlighting_function]} }	/* function */
			.CodeRay .gv { #{@config[:syntax_highlighting_global]} }	/* global variable */
			.CodeRay .i  { #{@config[:syntax_highlighting_integer]} }	/* integer */
			.CodeRay .il { #{@config[:syntax_highlighting_inline]} }	/* inline code */
			.CodeRay .iv { #{@config[:syntax_highlighting_instance]} }	/* instance variable */
			.CodeRay .pp { #{@config[:syntax_highlighting_doctype]} }	/* doctype */
			.CodeRay .r  { #{@config[:syntax_highlighting_keyword]} }	/* keyword */
			.CodeRay .rx { #{@config[:syntax_highlighting_regex]} }		/* regex */
			.CodeRay .s  { #{@config[:syntax_highlighting_string]} }	/* string */
			.CodeRay .sy { #{@config[:syntax_highlighting_symbol]} }	/* symbol */
			.CodeRay .ta { #{@config[:syntax_highlighting_html]} }		/* html tag */
			.CodeRay .pc { #{@config[:syntax_highlighting_boolean]} }	/* boolean */
		</style>" 
		return output
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

#Add .tbbc to Strings
class String
	def tbbc(conf = nil)
		bbc=TBBC.new
		bbc.conf(conf) if conf
		bbc.parse(self)
	end
end

t=TBBC.new
puts t.parse("[code lang=ruby]def test()\r\nputs \"test\"end[/code]")
