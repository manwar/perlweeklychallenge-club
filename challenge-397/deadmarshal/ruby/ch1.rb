#!/usr/local/env ruby

require "minitest/autorun"
require "set"

def absent_smallest_positive(arr)
  h = Set.new(arr)
  ret = [1,(arr.sum.to_f / arr.size).truncate + 1].max
  ret += 1 while h.include?(ret)
  ret
end

class TestAbsentSmallestPositive < Minitest::Test
  def test_example1
    assert_equal 7, absent_smallest_positive([1,2,4,5,6])
  end

  def test_example2
    assert_equal 1, absent_smallest_positive([-5,-2,-1,3])
  end

  def test_example3
    assert_equal 4, absent_smallest_positive((1..3).to_a)
  end

  def test_example4
    assert_equal 6, absent_smallest_positive([2,3,7,8])
  end

  def test_example5
    assert_equal 4, absent_smallest_positive([1,1,1,10])
  end
end

