#! /usr/bin/ruby

require 'set'

def distinctaverage(a0)
  a = a0.sort
  offset = a.size - 1
  res = Set.new
  0.upto(a.size / 2 - 1) do |i|
    res.add(a[i] + a[offset - i])
  end
  res.size
end

require 'test/unit'

class TestDistinctaverage < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, distinctaverage([1, 2, 4, 3, 5, 6]))
  end

  def test_ex2
    assert_equal(2, distinctaverage([0, 2, 4, 8, 3, 5]))
  end

  def test_ex3
    assert_equal(2, distinctaverage([7, 3, 1, 0, 5, 9]))
  end

end
