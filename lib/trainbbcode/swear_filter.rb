class TBBC

	SwearChracters = %w[! $ % ^ * ~]

	private
	
	def swear_filter(input)
		@config[:swear_words].each do |swear|
			input=input.gsub(/#{swear}/,swear_string(swear))
		end
		input
	end
	
	def swear_string(s)
		out=""
		s.split("").map { |split| out+= SwearChracters[rand(SwearChracters.count)] }
		out
	end
end
