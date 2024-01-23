#! /usr/bin/ruby

def splitstrings(a, sep)
  p = []
  a.each do |s|
    p += s.split(sep).find_all {|n| n.length > 0}
  end
  return p
end

require 'test/unit'

class TestSplitstrings < Test::Unit::TestCase

  def test_ex1
    assert_equal(['one', 'two', 'three', 'four', 'five', 'six'], splitstrings(['one.two.three', 'four.five', 'six'], '.'))
  end

  def test_ex2
    assert_equal(['perl', 'raku'], splitstrings(['$perl$$', '$$raku$'], '$'))
  end

end
