#! /usr/bin/ruby

def matchsticksquare(a)
  perimeter = a.sum
  if perimeter % 4 != 0
    return false
  end
  side = perimeter / 4
  ss = a.sort.reverse
  sidesleft = 4
  lengthleft = side
  while true do
    leftover = []
    ss.each do |m|
      if m > side
        return false
      end
      if m <= lengthleft
        lengthleft -= m
        if lengthleft == 0
          sidesleft -= 1
          lengthleft = side
        end
      else
        leftover.push(m)
      end
    end
    if leftover.length == 0
      break
    end
    ss = leftover
  end
  sidesleft == 0 && lengthleft == side
end

require 'test/unit'

class TestMatchsticksquare < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, matchsticksquare([1, 2, 2, 2, 1]))
  end

  def test_ex2
    assert_equal(false, matchsticksquare([2, 2, 2, 4]))
  end

  def test_ex3
    assert_equal(false, matchsticksquare([2, 2, 2, 2, 4]))
  end

  def test_ex4
    assert_equal(true, matchsticksquare([3, 4, 1, 4, 3, 1]))
  end

end
