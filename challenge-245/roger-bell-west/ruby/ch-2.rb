#! /usr/bin/ruby

def largestofthree(digits)
  ordered = digits.sort {|a,b| b <=> a}
  mx = 0
  (ordered.length-1).downto(0) do |n|
    ordered.combination(n + 1) do |c|
      t = 0
      c.each do |d|
        t *= 10
        t += d
      end
      if t > mx && t % 3 == 0 then
        mx = t
      end
    end
  end
  return mx
end

require 'test/unit'

class TestLargestofthree < Test::Unit::TestCase

  def test_ex1
    assert_equal(981, largestofthree([8, 1, 9]))
  end

  def test_ex2
    assert_equal(8760, largestofthree([8, 6, 7, 1, 0]))
  end

end
