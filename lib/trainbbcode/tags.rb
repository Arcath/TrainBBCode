module TrainBBCode
	Tags =  [[/\[b\](.*?)\[\/b\]/,'<strong>\1</strong>',:strong_enabled,"[b]BOLD[/b]","<strong>BOLD</strong>"],
		[/\[i\](.*?)\[\/i\]/,'<i>\1</i>',:italic_enabled,"[i]italics[/i]","<i>italics</i>"],
		[/\[u\](.*?)\[\/u\]/,'<u>\1</u>',:underline_enabled,"[u]underline[/u]","<u>underline</u>"],
		[/\[url\](.*?)\[\/url\]/,'<a href="\1" target="@config[:url_target]">\1</a>',:url_enabled,"[url]http://www.example.com[/url]","<a href=\"http://www.example.com\" target=\"_BLANK\">http://www.example.com</a>"],
		[/\[url=(.*?)\](.*?)\[\/url\]/,'<a href="\1" target="@config[:url_target]">\2</a>',:url_enabled,"[url=http://www.example.com]Example[/url]","<a href=\"http://www.example.com\" target=\"_BLANK\">Example</a>"],
		[/\[url=(.*?) target=(.*?)\](.*?)\[\/url\]/,'<a href="\1" target="\2">\3</a>',:url_enabled,"[url=http://www.example.com]Example[/url]","<a href=\"http://www.example.com\" target=\"_BLANK\">Example</a>"],
 		[/\[img\](.*?)\[\/img\]/,'<img src="\1" alt="@config[:image_alt]" />',:image_enabled,"[img]test.jpg[/img]","<img src=\"test.jpg\" alt=\"Posted Image\" />"],
		[/\[img alt=(.*?)\](.*?)\[\/img\]/,'<img src="\2" alt="\1" />',:image_enabled,"[img alt=Posted Image]test.jpg[/img]","<img src=\"test.jpg\" alt=\"Posted Image\" />"],
		[/\[ul\](.*?)\[\/ul\]/,'<ul>\1</ul>',:list_enabled,"[ul]list[/ul]","<ul>list</ul>"],
		[/\[ol\](.*?)\[\/ol\]/,'<ol>\1</ol>',:list_enabled,"[ol]list[/ol]","<ol>list</ol>"],
		[/\[li\](.*?)\[\/li\]/,'<li>\1</li>',:list_enabled,"[li]list[/li]","<li>list</li>"],
		[/\[quote\](.*?)\[\/quote\]/,'<blockquote>\1</blockquote>',:quote_enabled,"[quote]quote[/quote]","<blockquote>quote</blockquote>"],
		[/\[quote=(.*?)\](.*?)\[\/quote\]/,'<blockquote><i>Posted by <b>\1</b></i><br />\2</blockquote>',:quote_enabled,"[quote=user]quote[/quote]","<blockquote><i>Posted by <b>user</b></i><br />quote</blockquote>"],
		[/\[color=(.*?)\](.*?)\[\/color\]/,'<span style="color:\1;">\2</span>',:color_enabled,"[color=red]red text[/color]","<span style=\"color:red;\">red text</span>"],
		[/\[center\](.*?)\[\/center\]/,'<div style="text-align:center">\1</div>',:alignment_enabled,"[center]centered text[/center]","<div style=\"text-align:center\">centered text</div>"],
		[/\[left\](.*?)\[\/left\]/,'<div style="text-align:left">\1</div>',:alignment_enabled,"[left]left text[/left]","<div style=\"text-align:left\">left text</div>"],
		[/\[right\](.*?)\[\/right\]/,'<div style="text-align:right">\1</div>',:alignment_enabled,"[right]right text[/right]","<div style=\"text-align:right\">right text</div>"],
		[/\[acronym=(.*?)\](.*?)\[\/acronym\]/,'<acronym title="\1">\2</acronym>',:acronym_enabled,"[acronym=this]that[/acronym]","<acronym title=\"this\">that</acronym>"],
		[/\[table\](.*?)\[\/table\]/,'<table width="@config[:table_width]">\1</table>',:table_enabled,"[table]...[/table]","<table width=\"100%\">...</table>"],
		[/\[tr\](.*?)\[\/tr\]/,'<tr>\1</tr>',:table_enabled,"[tr]...[/tr]","<tr>...</tr>"],
		[/\[td\](.*?)\[\/td\]/,'<td>\1</td>',:table_enabled,"[td]...[/td]","<td>...</td>"],
		[/\[th\](.*?)\[\/th\]/,'<th>\1</th>',:table_enabled,"[th]...[/th]","<th>...</th>"],
		[/\[h1\](.*?)\[\/h1\]/,'<h1>\1</h1>',:header_enabled,'[h1]heading[/h1]',"<h1>heading</h1>"],
		[/\[h2\](.*?)\[\/h2\]/,'<h2>\1</h2>',:header_enabled,'[h2]heading[/h2]',"<h2>heading</h2>"],
		[/\[h3\](.*?)\[\/h3\]/,'<h3>\1</h3>',:header_enabled,'[h3]heading[/h3]',"<h3>heading</h3>"],
		[/\[h4\](.*?)\[\/h4\]/,'<h4>\1</h4>',:header_enabled,'[h4]heading[/h4]',"<h4>heading</h4>"]]
	
	private
	
	# Runs the given tag array on the given string.
	def self.runtag(s,tag)
		check = tag[2]
		check = @config.check_enabled(tag[2]) if is_symbol? tag[2]
		if tag[1] =~ /^Callback:/
			s = run_callback(s, tag[0], tag[1])
		else
			pattern = tag[1]
			s=s.gsub(tag[0],replace_config_values(pattern)) unless check == false
		end
		s
	end
	
	def self.is_symbol?(v)
		return false if (v == true or v == false)
		v == v.to_sym
	end
	
	def self.replace_config_values(s)
		if s.scan(/@config\[:(.*?)\]/) != [] then
			return s.gsub(/@config\[:(.*?)\]/,@config.from_sym($1.to_sym))
		else
			return s
		end
	end

	def self.run_callback(string, regex, callback)
		code = callback.gsub(/^Callback: /, '')
		output = string
		string.scan(regex).each do |arguments|
			arguments_pass = build_pass_string(arguments)
			replace = eval "#{code}#{arguments_pass}"
			output = output.sub(regex, replace)
		end
		output
	end

	def self.build_pass_string(args)
		output = "("
		args.map { |arg| output = "#{output}\"#{arg}\", " }
		output.gsub(/, $/,')')
	end
end
