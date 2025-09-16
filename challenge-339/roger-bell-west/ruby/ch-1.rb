#! /usr/bin/ruby

def maxdiff(a)
  md = 0
  0.upto(a.length - 2) do |w|
    (w + 1).upto(a.length - 1) do |x|
      (w + 1).upto(a.length - 2) do |y|
        if y != x
          (y + 1).upto(a.length - 1) do |z|
            if z != x
              v = (a[w] * a[x] - a[y] * a[z]).abs
              md = [md, v].max
            end
          end
        end
      end
    end
  end
  md
end

require 'test/unit'

class TestMaxdiff < Test::Unit::TestCase

  def test_ex1
    assert_equal(42, maxdiff([5, 9, 3, 4, 6]))
  end

  def test_ex2
    assert_equal(10, maxdiff([1, -2, 3, -4]))
  end

  def test_ex3
    assert_equal(10, maxdiff([-3, -1, -2, -4]))
  end

  def test_ex4
    assert_equal(50, maxdiff([10, 2, 0, 5, 1]))
  end

  def test_ex5
    assert_equal(44, maxdiff([7, 8, 9, 10, 10]))
  end

end
