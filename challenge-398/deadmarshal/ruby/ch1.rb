#!/usr/bin/env ruby

require "minitest/autorun"

def divisible_average(arr)
  f = arr.select {|x| x % 2 == 0 && x % 3 == 0}
  return 0 if f.empty?
  (f.sum.fdiv(f.size)).truncate
end

class DivisibleAverageTest < Minitest::Test
  def test_example_1
    assert_equal 18, divisible_average([18,5,7,11])
  end

  def test_example_2
    assert_equal 18, divisible_average([6,12,18,24,30,40])
  end

  def test_example_3
    assert_equal 0, divisible_average([3,9,15,21,27])
  end

  def test_example_4
    assert_equal 9, divisible_average([6,12,14,20])
  end

  def test_example_5
    assert_equal 8, divisible_average([6,6,6,12,12])
  end
end

