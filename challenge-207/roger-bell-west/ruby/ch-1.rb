#! /usr/bin/ruby

require 'test/unit'

def keyboardword(wl)
  re = Regexp.new("(?i)^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$", Regexp::IGNORECASE)
  return wl.find_all{|w| re.match(w)}
end

class TestKeyboardword < Test::Unit::TestCase

  def test_ex1
    assert_equal(['Alaska', 'Dad'], keyboardword(['Hello', 'Alaska', 'Dad', 'Peace']))
  end

  def test_ex2
    assert_equal([], keyboardword(['OMG', 'Bye']))
  end

end
