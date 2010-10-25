class TBBC
	
	# Returns the css required for coderay
	def css(config = nil)
		conf config
		output="		<style type=\"text/css\">
			.CodeRay {
				background-color: #232323;
				border: 1px solid black;
				font-family: 'Courier New', 'Terminal', monospace;
				color: #E6E0DB;
				padding: 3px 5px;
				overflow: auto;
				font-size: 12px;
				margin: 12px 0;
			}
			.CodeRay pre {
				margin: 0px;
				padding: 0px;
			}

			.CodeRay .an { #{@config[:syntax_highlighting_html]} }		/* html attribute */
			.CodeRay .c  { #{@config[:syntax_highlighting_comment]} }	/* comment */
			.CodeRay .ch { #{@config[:syntax_highlighting_escaped]} }	/* escaped character */
			.CodeRay .cl { #{@config[:syntax_highlighting_class]} }		/* class */
			.CodeRay .co { #{@config[:syntax_highlighting_constant]} }	/* constant */
			.CodeRay .fl { #{@config[:syntax_highlighting_float]} }		/* float */
			.CodeRay .fu { #{@config[:syntax_highlighting_function]} }	/* function */
			.CodeRay .gv { #{@config[:syntax_highlighting_global]} }	/* global variable */
			.CodeRay .i  { #{@config[:syntax_highlighting_integer]} }	/* integer */
			.CodeRay .il { #{@config[:syntax_highlighting_inline]} }	/* inline code */
			.CodeRay .iv { #{@config[:syntax_highlighting_instance]} }	/* instance variable */
			.CodeRay .pp { #{@config[:syntax_highlighting_doctype]} }	/* doctype */
			.CodeRay .r  { #{@config[:syntax_highlighting_keyword]} }	/* keyword */
			.CodeRay .rx { #{@config[:syntax_highlighting_regex]} }		/* regex */
			.CodeRay .s  { #{@config[:syntax_highlighting_string]} }	/* string */
			.CodeRay .sy { #{@config[:syntax_highlighting_symbol]} }	/* symbol */
			.CodeRay .ta { #{@config[:syntax_highlighting_html]} }		/* html tag */
			.CodeRay .pc { #{@config[:syntax_highlighting_boolean]} }	/* boolean */
		</style>" 
		if needs_html_safe? then
			return output.html_safe
		else
			return output
		end
	end
end
