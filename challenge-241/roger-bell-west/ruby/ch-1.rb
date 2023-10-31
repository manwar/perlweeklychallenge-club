#! /usr/bin/ruby

require 'set'

def arithmetictriplets(nums, diff)
  vs = Set.new(nums)
  return nums.find_all { |n| vs.include?(n + diff) && vs.include?(n + diff * 2) }.length
end

require 'test/unit'

class TestArithmetictriplets < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, arithmetictriplets([0, 1, 4, 6, 7, 10], 3))
  end

  def test_ex2
    assert_equal(2, arithmetictriplets([4, 5, 6, 7, 8, 9], 2))
  end

end
