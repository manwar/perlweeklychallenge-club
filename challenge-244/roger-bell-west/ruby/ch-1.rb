#! /usr/bin/ruby

def countsmaller(nums)
  b = nums.sort()
  sm = Hash.new
  l = 0
  b.each_with_index do |e, i|
    if i == 0 || e != l then
      sm[e] = i
      l = e
    end
  end
  return nums.map {|n| sm[n]}
end

require 'test/unit'

class TestCountsmaller < Test::Unit::TestCase

  def test_ex1
    assert_equal([4, 0, 1, 1, 3], countsmaller([8, 1, 2, 2, 3]))
  end

  def test_ex2
    assert_equal([2, 1, 0, 3], countsmaller([6, 5, 4, 8]))
  end

  def test_ex3
    assert_equal([0, 0, 0], countsmaller([2, 2, 2]))
  end

end
