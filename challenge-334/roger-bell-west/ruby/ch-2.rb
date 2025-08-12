#! /usr/bin/ruby

def nearestvalidpoint(x, y, points)
  ix = -1
  minmhd = -1
  points.each_with_index do |p, i|
    if p[0] == x || p[1] == y
      mhd = (p[0] - x).abs() + (p[1] - y).abs()
      if minmhd == -1 || mhd < minmhd
        minmhd = mhd
        ix = i
      end
    end
  end
  ix
end

require 'test/unit'

class TestNearestvalidpoint < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, nearestvalidpoint(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]]))
  end

  def test_ex2
    assert_equal(3, nearestvalidpoint(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]]))
  end

  def test_ex3
    assert_equal(-1, nearestvalidpoint(1, 1, [[2, 2], [3, 3], [4, 4]]))
  end

  def test_ex4
    assert_equal(0, nearestvalidpoint(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]]))
  end

  def test_ex5
    assert_equal(0, nearestvalidpoint(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]]))
  end

end
