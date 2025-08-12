#! /usr/bin/ruby

def rangesum(a, s, e)
  a.slice(s .. e).sum
end

require 'test/unit'

class TestRangesum < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, rangesum([-2, 0, 3, -5, 2, -1], 0, 2))
  end

  def test_ex2
    assert_equal(-3, rangesum([1, -2, 3, -4, 5], 1, 3))
  end

  def test_ex3
    assert_equal(2, rangesum([1, 0, 2, -1, 3], 3, 4))
  end

  def test_ex4
    assert_equal(-2, rangesum([-5, 4, -3, 2, -1, 0], 0, 3))
  end

  def test_ex5
    assert_equal(1, rangesum([-1, 0, 2, -3, -2, 1], 0, 2))
  end

end
