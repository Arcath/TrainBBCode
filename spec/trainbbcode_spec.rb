require 'lib/trainbbcode.rb'

def upcaser(input)
	input.upcase
end

describe TrainBBCode, "#parse" do
	TrainBBCode::Tags.each do |tag|
	   it "Should return #{tag[4]} for #{tag[3]}" do
	       tag[3].tbbc.should == tag[4]
       end
    end
end

describe String, "#tbbc" do
	it "Should return <i>italics</i> for [i]italics[/i]" do
		"[i]italics[/i]".tbbc.should == "<i>italics</i>"
	end
	
	it "Should return <strong>BOLD [i]italics[/i]</strong> when italics are disabled" do
		"[b]BOLD [i]italics[/i][/b]".tbbc(:italic_enabled => false).should == "<strong>BOLD [i]italics[/i]</strong>"
	end
	
	it "Should allow custom tags to run and return <strong><i>BOLD italics</i></strong> for [bi]BOLD italics[/bi]" do
		"[bi]BOLD italics[/bi]".tbbc(:custom_tags => [[/\[bi\](.*?)\[\/bi\]/,'<strong><i>\1</i></strong>',true]]).should == "<strong><i>BOLD italics</i></strong>"
	end

	it "Should allow custom tags to pass to callbacks" do
		"[up]HeLlo WorLd[/up]".tbbc(:custom_tags => [[/\[up\](.*?)\[\/up\]/,"Callback: upcaser",true]]).should == "HELLO WORLD"
	end

	it "Should not fail when a callback is defined but not used" do
		"[dw]HeLlo WorLd[/dw]".tbbc(:custom_tags => [[/\[up\](.*?)\[\/up\]/,"Callback: upcaser",true]]).should == "[dw]HeLlo WorLd[/dw]"
	end

	it "Should allow for 2 identical callbacks per string" do
		"[up]HeLlo WorLd[/up] and [up]Bye bYe WorLd[/up]".tbbc(:custom_tags => [[/\[up\](.*?)\[\/up\]/,"Callback: upcaser",true]]).should == "HELLO WORLD and BYE BYE WORLD"
	end
end
