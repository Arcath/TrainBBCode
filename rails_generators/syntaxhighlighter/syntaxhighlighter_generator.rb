class Syntaxhighlighter < Rails::Generator::Base
	def manifest
		record do |m|
			#Style Files
			m.directory "public/styles"
			m.file "styles/help.png", "public/styles/help.png"
			m.file "styles/magnifier.png", "public/styles/magnifier.png"
			m.file "styles/page_white_code.png", "public/styles/page_white_code.png"
			m.file "styles/page_white_copy.png", "public/styles/page_white_copy.png"
			m.file "styles/printer.png", "public/styles/printer.png"
			#Src Files
			m.directory "public/javascripts/syntax"
			m.file "src/shCore.js", "public/javascripts/syntax/shCore.js"
			m.file "src/shLegacy.js", "public/javascripts/syntax/shLegacy.js"
			#Script Files
			Dir.foreach("scripts") do |f|
				m.file "scripts/#{f}", "public/javascripts/syntax/#{f}"
			end
		end
	end
end
