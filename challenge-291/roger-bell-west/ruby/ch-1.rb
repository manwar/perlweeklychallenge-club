#! /usr/bin/ruby

def middleindex(a)
  r = a.sum
  l = 0
  a.each_with_index do |c, i|
    r -= c
    if r == l
      return i
    end
    l += c
  end
  -1
end

require 'test/unit'

class TestMiddleindex < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, middleindex([2, 3, -1, 8, 4]))
  end

  def test_ex2
    assert_equal(2, middleindex([1, -1, 4]))
  end

  def test_ex3
    assert_equal(-1, middleindex([2, 5]))
  end

end
