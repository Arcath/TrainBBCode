class TBBC
	# Parses the input and returns it in tbbc form.
	#
	#   TBBC.new.parse("[b]Bold[/b]")
	#
	# Would return "<strong>Bold</strong>"
	def parse(input)
		#Remove the < and > which will disable all HTML
		input=input.gsub("<","&lt;").gsub(">","&gt;") unless @config[:disable_html] == false
		#CodeRay
		input=coderay(input) unless @config[:syntax_highlighting] == false
		#Convert new lines to <br />'s
		input=input.gsub(/\n/,'<br />') unless @config[:newline_enabled] == false
		#[nobbc] tags
		input=nobbc input unless @config[:nobbc_enabled] == false
		#Swear Filtering
		input=swear_filter(input) unless @config[:swear_filter_enabled] == false
		#Loading Custom Tags
		#begin
			if @config[:custom_tags] then
				@config[:custom_tags].each do |tag|
					input=runtag(input,tag)
				end
			end
		#rescue
			#input+="<br />Custom Tags failed to run"
		#end
		#Loading Default Tags and applying them
		if @config[:allow_defaults] then
			TBBC::Tags.each do |tag|
				input=runtag(input,tag)
			end	
		end
		input=correctbrs input
		return input
	end
end
