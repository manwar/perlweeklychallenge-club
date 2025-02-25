#! /usr/bin/ruby

def maximumaverage(a, n)
  mx = 0
  a.each_cons(n) do |s|
    mx = [mx, s.sum].max
  end
  mx.to_f / n.to_f
end

require 'test/unit'

class TestMaximumaverage < Test::Unit::TestCase

  def test_ex1
    assert_equal(12.75, maximumaverage([1, 12, -5, -6, 50, 3], 4))
  end

  def test_ex2
    assert_equal(5, maximumaverage([5], 1))
  end

end
