#! /usr/bin/ruby

def maxdistance(a, b)
  l1, h1 = a.minmax
  l2, h2 = b.minmax
  [h1 - l2, h2 - l1].max
end

require 'test/unit'

class TestMaxdistance < Test::Unit::TestCase

  def test_ex1
    assert_equal(6, maxdistance([4, 5, 7], [9, 1, 3, 4]))
  end

  def test_ex2
    assert_equal(6, maxdistance([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]))
  end

  def test_ex3
    assert_equal(9, maxdistance([2, 1, 11, 3], [2, 5, 10, 2]))
  end

  def test_ex4
    assert_equal(2, maxdistance([1, 2, 3], [3, 2, 1]))
  end

  def test_ex5
    assert_equal(5, maxdistance([1, 0, 2, 3], [5, 0]))
  end

end
