class SyntaxhighlighterGenerator < Rails::Generator::Base
	def manifest
		record do |m|
			#Style Files
			m.directory "public/styles"
			m.file "styles/help.png", "public/styles/help.png"
			m.file "styles/magnifier.png", "public/styles/magnifier.png"
			m.file "styles/page_white_code.png", "public/styles/page_white_code.png"
			m.file "styles/page_white_copy.png", "public/styles/page_white_copy.png"
			m.file "styles/printer.png", "public/styles/printer.png"
			m.directory "public/stylesheets/syntax"
			m.file "styles/shCore.css", "public/stylesheets/syntax/shCore.css"
			m.file "styles/shThemeDefault.css", "public/stylesheets/syntax/shThemeDefault.css"
			m.file "styles/shThemeDjango.css", "public/stylesheets/syntax/shThemeDjango.css"
			m.file "styles/shThemeEclipse.css", "public/stylesheets/syntax/shThemeEclipse.css"
			m.file "styles/shThemeEmacs.css", "public/stylesheets/syntax/shThemeEmacs.css"
			m.file "styles/shThemeFadeToGrey.css", "public/stylesheets/syntax/shThemeFadeToGrey.css"
			m.file "styles/shThemeMidnight.css", "public/stylesheets/syntax/shThemeMidnight.css"
			m.file "styles/shThemeRDark.css", "public/stylesheets/syntax/shThemeRDark.css"
			#Src Files
			m.directory "public/javascripts/syntax"
			m.file "src/shCore.js", "public/javascripts/syntax/shCore.js"
			m.file "src/shLegacy.js", "public/javascripts/syntax/shLegacy.js"
			#Script Files
			Dir.foreach("vendor/plugins/TrainBBCode/rails_generators/syntaxhighlighter/templates/scripts") do |f|
				m.file "scripts/#{f}", "public/javascripts/syntax/#{f}"
			end
		end
	end
end
