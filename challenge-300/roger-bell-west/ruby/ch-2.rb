#! /usr/bin/ruby

require 'set'

def nestedarray(a)
  arr = 0
  0.upto(a.size - 1) do |i|
    trail = Set.new
    j = i
    while true
      j = a[j]
      if trail.include?(j)
        break
      end
      trail.add(j)
    end
    arr = [arr, trail.size].max
  end
  arr
end

require 'test/unit'

class TestNestedarray < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, nestedarray([5, 4, 0, 3, 1, 6, 2]))
  end

  def test_ex2
    assert_equal(1, nestedarray([0, 1, 2]))
  end

end
