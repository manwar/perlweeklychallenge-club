#! /usr/bin/ruby

def divisibleaverage(a)
  b = a.select{ |x| x % 6 == 0}
  if b.size == 0
    return 0
  end
  (b.sum.to_f / b.size.to_f + 0.5).to_i
end

require 'test/unit'

class TestDivisibleaverage < Test::Unit::TestCase

  def test_ex1
    assert_equal(18, divisibleaverage([18, 5, 7, 11]))
  end

  def test_ex2
    assert_equal(18, divisibleaverage([6, 12, 18, 24, 30, 40]))
  end

  def test_ex3
    assert_equal(0, divisibleaverage([3, 9, 15, 21, 27]))
  end

  def test_ex4
    assert_equal(9, divisibleaverage([6, 12, 14, 20]))
  end

  def test_ex5
    assert_equal(8, divisibleaverage([6, 6, 6, 12, 12]))
  end

end
