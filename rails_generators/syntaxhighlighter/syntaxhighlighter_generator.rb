class Syntaxhighlighter < Rails::Generator::Base
	def manifest
		record do |m|
			m.directory "public/styles"
			
		end
	end
end
