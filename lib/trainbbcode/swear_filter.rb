module TrainBBCode
    module SwearFilter
	    SwearChracters = %w[! $ % ^ * ~]
	    def self.parse(input)
		    TrainBBCode.config.swear_words.each do |swear|
			    input=input.gsub(/#{swear}/,swear_string(swear))
		    end
		    input
	    end
	
	    def self.swear_string(s)
		    out=""
		    s.split("").map { |split| out+= SwearChracters[rand(SwearChracters.count)] }
		    out
	    end
    end
end
