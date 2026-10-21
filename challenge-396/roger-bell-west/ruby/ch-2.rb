#! /usr/bin/ruby

def trionicarray(a)
  state = 0
  prev = a[0]
  1.upto(a.length - 1) do |i|
    n = a[i]
    dir = 0
    if n > prev
      dir = 1
    elsif n < prev
      dir = -1
    end
    if dir == 0
      return false
    end
    case state
    when 0
      if dir == 1
        state = 1
      else
        return false
      end
    when 1
      if dir == -1
        state = 2
      end
    when 2
      if dir == 1
        state = 3
      end
    when 3
      if dir == -1
        return false
      end
    else
      return false
    end
    prev = n
  end
  state == 3
end

require 'test/unit'

class TestTrionicarray < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, trionicarray([1, 3, 5, 4, 2, 6, 8]))
  end

  def test_ex2
    assert_equal(false, trionicarray([1, 4, 4, 2, 1, 3, 5]))
  end

  def test_ex3
    assert_equal(true, trionicarray([2, 10, 3, 1, 9]))
  end

  def test_ex4
    assert_equal(false, trionicarray([1, 2, 3, 4, 3, 2, 1]))
  end

  def test_ex5
    assert_equal(false, trionicarray([1, 3, 2, 4, 1, 5, 2]))
  end

end
