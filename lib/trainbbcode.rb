class TBBC
	def parse(s)
		#First off remove the < and > which will disable all HTML
		s=s.gsub("<","&lt;").gsub(">","&gt;")
		#Convert new lines to <br />'s
		s=s.gsub(/\n/,'<br />')
		#Tags
		s=s.gsub(/\[b\](.*?)\[\/b\]/,'<strong>\1</strong>')
		s=s.gsub(/\[i\](.*?)\[\/b\]/,'<i>\1</i>')
		s=s.gsub(/\[u\](.*?)\[\/u\]/,'<u>\1</u>')
		s=s.gsub(/\[url\](.*?)\[\/url\]/,'<a href="\1" target="_BLANK">\1</a>')
		s=s.gsub(/\[url=(.*?)\](.*?)\[\/url\]/,'<a href="\1" target="_BLANK">\2</a>')
		
		return s
	end
end

class String
	def tbbc
		bbc=TBBC.new
		bbc.parse(self)
	end
end
