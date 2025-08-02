#! /usr/bin/ruby

def popcount(x0)
  x = x0
  c = 0
  while x > 0 do
    x &= x - 1
    c += 1
  end
  return c
end

def sumofvalues(a, k)
  s = 0
  a.each_with_index do |n, i|
    if popcount(i) == k then
      s += n
    end
  end
  return s
end

require 'test/unit'

class TestSumofvalues < Test::Unit::TestCase

  def test_ex1
    assert_equal(17, sumofvalues([2, 5, 9, 11, 3], 1))
  end

  def test_ex2
    assert_equal(11, sumofvalues([2, 5, 9, 11, 3], 2))
  end

  def test_ex3
    assert_equal(2, sumofvalues([2, 5, 9, 11, 3], 0))
  end

end
