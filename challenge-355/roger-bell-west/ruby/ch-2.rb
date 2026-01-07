#! /usr/bin/ruby

def mountainarray(a)
  state = 0
  a.each_cons(2) do |b|
    if b[1] > b[0]
      case state
      when 0, 1
        state = 1
      else
        return false
      end
    elsif b[1] < b[0]
      case state
      when 1, 2
        state = 2
      else
        return false
      end
    else
      return false
    end
  end
  return state == 2
end

require 'test/unit'

class TestMountainarray < Test::Unit::TestCase

  def test_ex1
    assert_equal(false, mountainarray([1, 2, 3, 4, 5]))
  end

  def test_ex2
    assert_equal(true, mountainarray([0, 2, 4, 6, 4, 2, 0]))
  end

  def test_ex3
    assert_equal(false, mountainarray([5, 4, 3, 2, 1]))
  end

  def test_ex4
    assert_equal(false, mountainarray([1, 3, 5, 5, 4, 2]))
  end

  def test_ex5
    assert_equal(true, mountainarray([1, 3, 2]))
  end

end
