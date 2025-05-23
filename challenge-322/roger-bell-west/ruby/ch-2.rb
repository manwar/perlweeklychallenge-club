#! /usr/bin/ruby

require 'set'

def rankarray(a)
  b = a.to_set.to_a.sort
  c = {}
  b.each_with_index do |n, i|
    c[n] = i + 1
  end
  out = []
  a.each do |v|
    out.push(c[v])
  end
  out
end

require 'test/unit'

class TestRankarray < Test::Unit::TestCase

  def test_ex1
    assert_equal([4, 1, 3, 2], rankarray([55, 22, 44, 33]))
  end

  def test_ex2
    assert_equal([1, 1, 1], rankarray([10, 10, 10]))
  end

  def test_ex3
    assert_equal([4, 1, 1, 3, 2], rankarray([5, 1, 1, 4, 3]))
  end

end
