#! /usr/bin/ruby

def elementdigitsum(a)
  delta = 0
  a.each do |n0|
    n = n0.div(10)
    m = 10
    while n > 0 do
      n, digit = n.divmod(10)
      delta += digit * (m - 1)
      m *= 10
    end
  end
  return delta
end

require 'test/unit'

class TestElementdigitsum < Test::Unit::TestCase

  def test_ex1
    assert_equal(36, elementdigitsum([1, 2, 3, 45]))
  end

  def test_ex2
    assert_equal(9, elementdigitsum([1, 12, 3]))
  end

  def test_ex3
    assert_equal(0, elementdigitsum([1, 2, 3, 4]))
  end

  def test_ex4
    assert_equal(1296, elementdigitsum([236, 416, 336, 350]))
  end

end
