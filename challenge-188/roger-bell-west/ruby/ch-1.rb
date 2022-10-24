#! /usr/bin/ruby

require 'test/unit'

def divisiblepairs(a, k)
  ct = 0
  a.combination(2) do |b|
    if (b[0] + b[1]) % k == 0 then
      ct += 1
    end
  end
  return ct
end

class TestDivisiblepairs < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, divisiblepairs([4, 5, 1, 6], 2))
  end

  def test_ex2
    assert_equal(2, divisiblepairs([1, 2, 3, 4], 2))
  end

  def test_ex3
    assert_equal(2, divisiblepairs([1, 3, 4, 5], 3))
  end

  def test_ex4
    assert_equal(2, divisiblepairs([5, 1, 2, 3], 4))
  end

  def test_ex5
    assert_equal(1, divisiblepairs([7, 2, 4, 5], 4))
  end
end
