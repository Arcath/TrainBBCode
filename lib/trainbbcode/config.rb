module TrainBBCode
    class Config
        attr_accessor :configed_by, :image_alt, :url_target, :allow_defaults, :table_width, :syntax_highlighting, :syntax_highlighting_html,
                      :syntax_highlighting_comment, :syntax_highlighting_escaped, :syntax_highlighting_class, :syntax_highlighting_constant,
                      :syntax_highlighting_float, :syntax_highlighting_function, :syntax_highlighting_global, :syntax_highlighting_integer,
                      :syntax_highlighting_inline, :syntax_highlighting_instance, :syntax_highlighting_doctype, :syntax_highlighting_keyword,
                      :syntax_highlighting_regex, :syntax_highlighting_string, :syntax_highlighting_symbol, :syntax_highlighting_html,
                      :syntax_highlighting_boolean, :syntax_highlighting_line_numbers, :swear_words, :custom_tags, :disable_html, :newline_enabled,
                      :nobbc_enabled, :swear_filter_enabled
        
        def initialize
            set_defaults
        end
        
        def check_enabled(sym)
            eval "@#{sym.to_s}"
        end
        
        def from_sym(sym)
            eval "@#{sym.to_s}"
        end
        
        def set_from_sym(k, v)
            eval "@#{k.to_s} = #{v.inspect}"
        end
        
        private
        
        def set_defaults
           @configed_by                     ||= "user"
           @image_alt			            ||= "Posted Image" 
   		   @url_target			            ||= "_BLANK"
   		   @allow_defaults		            ||= true
   		   @table_width			            ||= "100%"
   		   @syntax_highlighting		        ||= true
   		   @syntax_highlighting_html	    ||= "color:#E7BE69"
   		   @syntax_highlighting_comment	    ||= "color:#BC9358; font-style: italic;"
   		   @syntax_highlighting_escaped	    ||= "color:#509E4F"
   		   @syntax_highlighting_class       ||= "color:#FFF"
   		   @syntax_highlighting_constant	||= "color:#FFF"
   		   @syntax_highlighting_float       ||= "color:#A4C260"
   		   @syntax_highlighting_function	||= "color:#FFC56D"
   		   @syntax_highlighting_global	    ||= "color:#D0CFFE"
   		   @syntax_highlighting_integer	    ||= "color:#A4C260"
   		   @syntax_highlighting_inline	    ||= "background:#151515"
   		   @syntax_highlighting_instance    ||= "color:#D0CFFE"
   		   @syntax_highlighting_doctype	    ||= "color:#E7BE69"
   		   @syntax_highlighting_keyword	    ||= "color:#CB7832"
   		   @syntax_highlighting_regex       ||= "color:#A4C260"
   		   @syntax_highlighting_string	    ||= "color:#A4C260"
   		   @syntax_highlighting_symbol	    ||= "color:#6C9CBD"
   		   @syntax_highlighting_html	    ||= "color:#E7BE69"
   		   @syntax_highlighting_boolean	    ||= "color:#6C9CBD"
   		   @syntax_highlighting_line_numbers||= :inline
   		   @swear_words			            ||= []
   		   @custom_tags                     ||= []
   		   @disable_html                    ||= true
   		   @newline_enabled                 ||= true
   		   @nobbc_enabled                   ||= true
   		   @swear_filter_enabled            ||= true
        end
    end
end