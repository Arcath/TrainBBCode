class String
	# Allows for "[b]Bold[/b]".tbbc 
	#
	# This method is also configurable, taking the normal configuration options.
	#
	#    "[b]Bold [i]and italic[/i][/b]".tbbc(:strong_enabled => false, :italic_enabled => false)
	#
	# Will return "[b]Bold [i]and italic[/i][/b]"
	def tbbc(conf = nil)
		if !(TrainBBCode.configured?) || conf != nil
		    TrainBBCode.configure do |c|
		        if conf
		            conf.each do |k, v|
		                c.set_from_sym(k,v)
	                end
                end
	        end
	    end
		TrainBBCode.parse(self)
	end
end
