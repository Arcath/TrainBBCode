require 'lib/trainbbcode.rb'

describe TBBC, "#parse" do
	it "Should return <strong>BOLD</strong> for [b]BOLD[/b]" do
		TBBC.new.parse("[b]BOLD[/b]").should == "<strong>BOLD</strong>"
	end
end

describe String, "#tbbc" do
	it "Should return <i>italics</i> for [i]italics[/i]" do
		"[i]italics[/i]".tbbc.should == "<i>italics</i>"
	end
	
	it "Should return <strong>BOLD [i]italics[/i]</strong> when italics are disabled" do
		"[b]BOLD [i]italics[/i][/b]".tbbc(:italic_enabled => false).should == "<strong>BOLD [i]italics[/i]</strong>"
	end
end
