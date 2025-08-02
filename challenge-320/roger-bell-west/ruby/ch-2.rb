#! /usr/bin/ruby

def sumdifference(a)
  delta = 0
  a.each do |x|
    if x >= 10
      digitsum = 0
      xa = x
      while xa > 0
        (xa, y) = xa.divmod(10)
        digitsum += y
      end
      delta += x - digitsum
    end
  end
  delta
end

require 'test/unit'

class TestSumdifference < Test::Unit::TestCase

  def test_ex1
    assert_equal(18, sumdifference([1, 23, 4, 5]))
  end

  def test_ex2
    assert_equal(0, sumdifference([1, 2, 3, 4, 5]))
  end

  def test_ex3
    assert_equal(27, sumdifference([1, 2, 34]))
  end

end
