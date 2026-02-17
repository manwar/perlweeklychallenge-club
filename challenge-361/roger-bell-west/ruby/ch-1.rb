#! /usr/bin/ruby

def zeckendorfrepresentation(a)
  fib = [0, 1]
  while fib[-1] <= a
    fib.push(fib[-1] + fib[-2])
  end
  fib.pop
  res = []
  aw = a
  while aw > 0
    res.push(fib[-1])
    aw -= fib[-1]
    fib.pop
    fib.pop
    while fib[-1] > aw
      fib.pop
    end
  end
  res
end

require 'test/unit'

class TestZeckendorfrepresentation < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 1], zeckendorfrepresentation(4))
  end

  def test_ex2
    assert_equal([8, 3, 1], zeckendorfrepresentation(12))
  end

  def test_ex3
    assert_equal([13, 5, 2], zeckendorfrepresentation(20))
  end

  def test_ex4
    assert_equal([89, 5, 2], zeckendorfrepresentation(96))
  end

  def test_ex5
    assert_equal([89, 8, 3], zeckendorfrepresentation(100))
  end

end
