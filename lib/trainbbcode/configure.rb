module TrainBBCode
	# Configures TBBC, loads a config file if present and the defaults 
	def conf(config)
		@config = config || {}
		load_config_from_defaults
		if File.exist?("config/tbbc.rb")
			load_config_from_file
		end
	end
	
	private
	
	# Loads the users config file
	def load_config_from_file
		load 'config/tbbc.rb'
		user_config
	end
	
	# Loads the default config.
	#
	# Is non-overiding so any config set by the user in thier own file remains.
	def load_config_from_defaults
		@config[:configed_by]			            ||= "user"
		@config[:image_alt]			                ||= "Posted Image" 
		@config[:url_target]			            ||= "_BLANK"
		@config[:allow_defaults]		            ||= true
		@config[:table_width]			            ||= "100%"
		@config[:syntax_highlighting]		        ||= true
		@config[:syntax_highlighting_html]	        ||= "color:#E7BE69"
		@config[:syntax_highlighting_comment]	    ||= "color:#BC9358; font-style: italic;"
		@config[:syntax_highlighting_escaped]	    ||= "color:#509E4F"
		@config[:syntax_highlighting_class]	        ||= "color:#FFF"
		@config[:syntax_highlighting_constant]	    ||= "color:#FFF"
		@config[:syntax_highlighting_float]	        ||= "color:#A4C260"
		@config[:syntax_highlighting_function]	    ||= "color:#FFC56D"
		@config[:syntax_highlighting_global]	    ||= "color:#D0CFFE"
		@config[:syntax_highlighting_integer]	    ||= "color:#A4C260"
		@config[:syntax_highlighting_inline]	    ||= "background:#151515"
		@config[:syntax_highlighting_instance]	    ||= "color:#D0CFFE"
		@config[:syntax_highlighting_doctype]	    ||= "color:#E7BE69"
		@config[:syntax_highlighting_keyword]	    ||= "color:#CB7832"
		@config[:syntax_highlighting_regex]	        ||= "color:#A4C260"
		@config[:syntax_highlighting_string]	    ||= "color:#A4C260"
		@config[:syntax_highlighting_symbol]	    ||= "color:#6C9CBD"
		@config[:syntax_highlighting_html]	        ||= "color:#E7BE69"
		@config[:syntax_highlighting_boolean]	    ||= "color:#6C9CBD"
		@config[:syntax_highlighting_line_numbers]  ||= :inline
		@config[:swear_words]			            ||= []
	end
end
