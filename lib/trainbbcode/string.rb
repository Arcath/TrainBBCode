class String
	# Allows for "[b]Bold[/b]".tbbc 
	#
	# This method is also configurable, taking the normal configuration options.
	#
	#    "[b]Bold [i]and italic[/i][/b]".tbbc(:strong_enabled => false, :italic_enabled => false)
	#
	# Will return "[b]Bold [i]and italic[/i][/b]"
	def tbbc(conf = nil)
		bbc=TBBC.new
		bbc.conf(conf) if conf
		bbc.parse(self)
	end
end
