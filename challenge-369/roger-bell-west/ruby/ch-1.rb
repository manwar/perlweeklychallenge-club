#! /usr/bin/ruby

def validtag(a)
  p = "#"
  up = false
  a.chars.each do |c|
    if /[a-z]/i =~ c
      cc = c
      if up
        cc.upcase!
        up = false
      else
        cc.downcase!
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

require 'test/unit'

class TestValidtag < Test::Unit::TestCase

  def test_ex1
    assert_equal('#cookingWithIngredients', validtag('Cooking with 5 ingredients!'))
  end

  def test_ex2
    assert_equal('#thelastofthemohicans', validtag('the-last-of-the-mohicans'))
  end

  def test_ex3
    assert_equal('#extraSpacesHere', validtag('  extra spaces here'))
  end

  def test_ex4
    assert_equal('#iphoneProMaxReview', validtag('iPhone 15 Pro Max Review'))
  end

  def test_ex5
    assert_equal('#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn', validtag('Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!'))
  end

end
