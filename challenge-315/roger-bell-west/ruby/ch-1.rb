#! /usr/bin/ruby

def findwords(a, b)
  out = []
  a.each_with_index do |x, i|
    if !x.index(b).nil?
      out.push(i)
    end
  end
  out
end

require 'test/unit'

class TestFindwords < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 1, 2], findwords(['the', 'weekly', 'challenge'], 'e'))
  end

  def test_ex2
    assert_equal([0, 2], findwords(['perl', 'raku', 'python'], 'p'))
  end

  def test_ex3
    assert_equal([0, 2, 3], findwords(['abc', 'def', 'bbb', 'bcd'], 'b'))
  end

end
