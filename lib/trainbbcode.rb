class TBBC
	def parse(s)
		#First off remove the < and > which will disable all HTML
		s=s.gsub("<","&lt;").gsub(">","&gt;")
		#Convert new lines to <br />'s
		s=s.gsub(/\n/,'<br />')
		#Tags
		s=s.gsub(/\[b\](.*?)\[\/b\]/,'<strong>\1</strong>')
		
		return s
	end
end

class String
	def tbbc
		bbc=TBBC.new
		bbc.parse(self)
	end
end
