#! /usr/bin/ruby

def sortoddeven(a)
  odds = []
  evens = []
  a.each_with_index do |x, i|
    if i % 2 == 0
      evens.push(x)
    else
      odds.push(x)
    end
  end
  evens = evens.sort
  odds = odds.sort.reverse
  out = []
  0.upto([evens.size, odds.size].max) do |i|
    if i < evens.size
      out.push(evens[i])
    end
    if i < odds.size
      out.push(odds[i])
    end
  end
  out
end

require 'test/unit'

class TestSortoddeven < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 3, 4, 1], sortoddeven([4, 1, 2, 3]))
  end

  def test_ex2
    assert_equal([3, 1], sortoddeven([3, 1]))
  end

  def test_ex3
    assert_equal([2, 3, 4, 1, 5], sortoddeven([5, 3, 2, 1, 4]))
  end

end
