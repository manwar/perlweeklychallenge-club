#! /usr/bin/ruby

def arithmeticprogression(a0)
  epsilon = 0.001
  a = a0.sort
  delta = a[1] - a[0]
  a.drop(1).each_slice(2) do |v|
    if (v[1] - v[0] - delta).abs > epsilon
      return false
    end
  end
  true
end

require 'test/unit'

class TestArithmeticprogression < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, arithmeticprogression([1, 3, 5, 7, 9]))
  end

  def test_ex2
    assert_equal(true, arithmeticprogression([9, 1, 7, 5, 3]))
  end

  def test_ex3
    assert_equal(false, arithmeticprogression([1, 2, 4, 8, 16]))
  end

  def test_ex4
    assert_equal(true, arithmeticprogression([5, -1, 3, 1, -3]))
  end

  def test_ex5
    assert_equal(true, arithmeticprogression([1.5, 3, 0, 4.5, 6]))
  end

end
