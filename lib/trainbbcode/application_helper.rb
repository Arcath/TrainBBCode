module TBBCHelper
	def tbbc_css(config = nil)
		bbc=TBBC.new
		bbc.conf(config) if config
		bbc.css
	end
end