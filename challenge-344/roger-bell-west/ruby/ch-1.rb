#! /usr/bin/ruby

def u2a(a)
  p = a
  if p > 0
    out = []
    while p > 0
      (p, x) = p.divmod(10)
      out.unshift(x)
    end
    out
  else
    [0]
  end
end

def a2u(a)
  acc = 0
  a.each do |d|
    acc *= 10
    acc += d
  end
  acc
end

def arrayformcompute(a, b)
  u2a(a2u(a) + b)
end

require 'test/unit'

class TestArrayformcompute < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 2, 4, 6], arrayformcompute([1, 2, 3, 4], 12))
  end

  def test_ex2
    assert_equal([4, 5, 5], arrayformcompute([2, 7, 4], 181))
  end

  def test_ex3
    assert_equal([1, 0, 0, 0], arrayformcompute([9, 9, 9], 1))
  end

  def test_ex4
    assert_equal([1, 9, 9, 9, 9], arrayformcompute([1, 0, 0, 0, 0], 9999))
  end

  def test_ex5
    assert_equal([1, 0, 0, 0], arrayformcompute([0], 1000))
  end

end
