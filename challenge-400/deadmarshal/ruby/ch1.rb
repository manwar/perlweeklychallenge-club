#!/usr/bin/env ruby

require 'minitest/autorun'

def largest_interval(n)
  nums = (1..n).reject{|i| i.to_s =~ /(.).*\1/}
  nums.each_cons(2).map{|a,b| b - a}.max || 0
end

class TestLargestInterval < Minitest::Test
  def test_examples
    assert_equal 2,   largest_interval(20),    'Example 1'
    assert_equal 4,   largest_interval(110),   'Example 2'
    assert_equal 11,  largest_interval(500),   'Example 3'
    assert_equal 105, largest_interval(2026),  'Example 4'
    assert_equal 105, largest_interval(10000), 'Example 5'
  end
end

