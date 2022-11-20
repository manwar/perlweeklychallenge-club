#! /usr/bin/ruby

require 'test/unit'

def twicelargest(l0)
  l = l0.sort
  return l[-1] >= (2 * l[-2])
end

class TestDivisiblepairs < Test::Unit::TestCase

  def test_ex1
    assert_equal(false, twicelargest([1, 2, 3, 4]))
  end

  def test_ex2
    assert_equal(true, twicelargest([1, 2, 0, 5]))
  end

  def test_ex3
    assert_equal(true, twicelargest([2, 6, 3, 1]))
  end

  def test_ex4
    assert_equal(false, twicelargest([4, 5, 2, 3]))
  end
end
