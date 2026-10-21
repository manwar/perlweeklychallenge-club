#! /usr/bin/ruby

require 'set'

def finishingorder(order, friends)
  wanted = friends.to_set
  order.select{|x| wanted.include?(x)}
end

require 'test/unit'

class TestFinishingorder < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 4, 2], finishingorder([3, 1, 4, 2, 5], [1, 4, 2]))
  end

  def test_ex2
    assert_equal([5, 3, 1], finishingorder([5, 4, 3, 2, 1], [1, 3, 5]))
  end

  def test_ex3
    assert_equal([2, 4, 1, 3], finishingorder([2, 4, 1, 3], [1, 2, 3, 4]))
  end

  def test_ex4
    assert_equal([3], finishingorder([4, 1, 3, 2], [3]))
  end

  def test_ex5
    assert_equal([1, 3, 2], finishingorder([1, 3, 2, 6, 5, 4], [1, 2, 3]))
  end

end
