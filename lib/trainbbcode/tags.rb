class TBBC
	Tags =  [[/\[b\](.*?)\[\/b\]/,'<strong>\1</strong>',:strong_enabled],
		[/\[i\](.*?)\[\/i\]/,'<i>\1</i>',:italic_enabled],
		[/\[u\](.*?)\[\/u\]/,'<u>\1</u>',:underline_enabled],
		[/\[url\](.*?)\[\/url\]/,'<a href="\1" target="@config[:url_target]">\1</a>',:url_enabled],
		[/\[url=(.*?)\](.*?)\[\/url\]/,'<a href="\1" target="@config[:url_target]">\2</a>',:url_enabled],
		[/\[url=(.*?) target=(.*?)\](.*?)\[\/url\]/,'<a href="\1" target="\2">\3</a>',:url_enabled],
		[/\[img\](.*?)\[\/img\]/,'<img src="\1" alt="@config[:image_alt]" />',:image_enabled],
		[/\[img alt=(.*?)\](.*?)\[\/img\]/,'<img src="\2" alt="\1" />',:image_enabled],
		[/\[ul\](.*?)\[\/ul\]/,'<ul>\1</ul>',:list_enabled],
		[/\[ol\](.*?)\[\/ol\]/,'<ol>\1</ol>',:list_enabled],
		[/\[li\](.*?)\[\/li\]/,'<li>\1</li>',:list_enabled],
		[/\[quote\](.*?)\[\/quote\]/,'<blockquote>\1</blockquote>',:quote_enabled],
		[/\[quote=(.*?)\](.*?)\[\/quote\]/,'<blockquote><i>Posted by <b>\1</b></i><br />\2</blockquote>',:quote_enabled],
		[/\[color=(.*?)\](.*?)\[\/color\]/,'<span style="color:\1;">\2</span>',:color_enabled],
		[/\[center\](.*?)\[\/center\]/,'<div style="text-align:center">\1</div>',:alignment_enabled],
		[/\[left\](.*?)\[\/left\]/,'<div style="text-align:left">\1</div>',:alignment_enabled],
		[/\[right\](.*?)\[\/right\]/,'<div style="text-align:right">\1</div>',:alignment_enabled],
		[/\[acronym=(.*?)\](.*?)\[\/acronym\]/,'<acronym title="\1">\2</acronym>',:acronym_enabled],
		[/\[table\](.*?)\[\/table\]/,'<table width="@config[:table_width]">\1</table>',:table_enabled],
		[/\[tr\](.*?)\[\/tr\]/,'<tr>\1</tr>',:table_enabled],
		[/\[td\](.*?)\[\/td\]/,'<td>\1</td>',:table_enabled],
		[/\[th\](.*?)\[\/th\]/,'<th>\1</th>',:table_enabled]]
	
	private
	
	# Runs the given tag array on the given string.
	def runtag(s,tag)
		check = tag[2]
		check = @config[tag[2]] if is_symbol? tag[2]
		s=s.gsub(tag[0],replace_config_values(tag[1])) unless check == false
		s
	end
	
	def is_symbol?(v)
		return false if (v == true or v == false)
		v == v.to_sym
	end
	
	def replace_config_values(s)
		if s.scan(/@config\[:(.*?)\]/) != [] then
			return s.gsub(/@config\[:(.*?)\]/,@config[$1.to_sym])
		else
			return s
		end
	end
end
