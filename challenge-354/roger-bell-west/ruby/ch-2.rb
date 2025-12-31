#! /usr/bin/ruby

def shiftgrid(gi, k0)
  wi = []
  gi.each do |x|
    wi.concat(x)
  end
  k = k0 % wi.size
  wo = wi[wi.size - k .. ]
  wo.concat(wi[0 .. wi.size - k - 1])
  wo.each_slice(gi[0].size).to_a
end

require 'test/unit'

class TestShiftgrid < Test::Unit::TestCase

  def test_ex1
    assert_equal([[9, 1, 2], [3, 4, 5], [6, 7, 8]], shiftgrid([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1))
  end

  def test_ex2
    assert_equal([[40, 10], [20, 30]], shiftgrid([[10, 20], [30, 40]], 1))
  end

  def test_ex3
    assert_equal([[6, 1], [2, 3], [4, 5]], shiftgrid([[1, 2], [3, 4], [5, 6]], 1))
  end

  def test_ex4
    assert_equal([[2, 3, 4], [5, 6, 1]], shiftgrid([[1, 2, 3], [4, 5, 6]], 5))
  end

  def test_ex5
    assert_equal([[4, 1, 2, 3]], shiftgrid([[1, 2, 3, 4]], 1))
  end

end
