#! /usr/bin/ruby

def grouphero(nums0)
  nums = nums0.sort()
  sum = 0
  1.upto(nums.length) do |l|
    nums.combination(l) do |c|
      sum += c[-1] * c[-1] * c[0]
    end
  end
  return sum
end

require 'test/unit'

class TestGrouphero < Test::Unit::TestCase

  def test_ex1
    assert_equal(141, grouphero([2, 1, 4]))
  end

end
