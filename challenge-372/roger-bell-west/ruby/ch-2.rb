#! /usr/bin/ruby

def largestsubstring(a)
  cc = a.chars()
  (cc.size - 1).downto(1) do |offset|
    0.upto(cc.size - 1 - offset) do |x|
      if cc[x] == cc[x + offset]
        return offset - 1
      end
    end
  end
  -1
end

require 'test/unit'

class TestLargestsubstring < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, largestsubstring('aaaaa'))
  end

  def test_ex2
    assert_equal(5, largestsubstring('abcdeba'))
  end

  def test_ex3
    assert_equal(0, largestsubstring('abbc'))
  end

  def test_ex4
    assert_equal(4, largestsubstring('abcaacbc'))
  end

  def test_ex5
    assert_equal(2, largestsubstring('laptop'))
  end

end
