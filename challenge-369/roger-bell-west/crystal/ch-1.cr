#! /usr/bin/crystal

def validtag(a)
  p = "#"
  up = false
  a.chars.each do |c|
    if c.letter?
      cc = c
      if up
        cc = cc.upcase
        up = false
      else
        cc = cc.downcase
      end
      p += cc
    elsif c == ' ' && p.size > 1
      up = true
    end
  end
  if p.size > 100
    p = p[0, 100]
  end
  p
end

require "spec"
describe "validtag" do
  it "test_ex1" do
    validtag("Cooking with 5 ingredients!").should eq "#cookingWithIngredients"
  end
  it "test_ex2" do
    validtag("the-last-of-the-mohicans").should eq "#thelastofthemohicans"
  end
  it "test_ex3" do
    validtag("  extra spaces here").should eq "#extraSpacesHere"
  end
  it "test_ex4" do
    validtag("iPhone 15 Pro Max Review").should eq "#iphoneProMaxReview"
  end
  it "test_ex5" do
    validtag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!").should eq "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"
  end
end
