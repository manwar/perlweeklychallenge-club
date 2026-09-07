#! /usr/bin/ruby

def zigzagsubarray(a)
  mx = [1, a.length].min
  0.upto(a.length - 1) do |i|
    o = 0
    lastdir = 0
    i.upto(a.length - 1) do |j|
      thisdir = 0
      if j > i
        if a[j] > o
          thisdir = 1
          mx = [mx, 2].max
        elsif a[j] < o
          thisdir = -1
          mx = [mx, 2].max
        end
      end
      if (j > i && thisdir == 0) || (j > i + 1 && thisdir * lastdir != -1)
        break
      end
      o = a[j]
      lastdir = thisdir
      mx = [mx, j - i + 1].max
    end
  end
  mx
end

require 'test/unit'

class TestZigzagsubarray < Test::Unit::TestCase

  def test_ex1
    assert_equal(5, zigzagsubarray([9, 4, 2, 10, 7, 8, 8, 1, 9]))
  end

  def test_ex2
    assert_equal(6, zigzagsubarray([1, 7, 4, 9, 2, 5]))
  end

  def test_ex3
    assert_equal(2, zigzagsubarray([1, 2, 3, 4, 5]))
  end

  def test_ex4
    assert_equal(1, zigzagsubarray([4, 4, 4]))
  end

  def test_ex5
    assert_equal(3, zigzagsubarray([10, 20, 15, 12, 18]))
  end

end
