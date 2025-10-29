#! /usr/bin/ruby

def lastvisitor(a)
  seen = []
  ans = []
  minusones = 0
  a.each do |n|
    if n == -1
      minusones += 1
      if minusones <= seen.size
        ans.push(seen[minusones - 1])
      else
        ans.push(-1)
      end
    else
      seen.unshift(n)
      minusones = 0
    end
  end
  ans
end

require 'test/unit'

class TestLastvisitor < Test::Unit::TestCase

  def test_ex1
    assert_equal([5, -1], lastvisitor([5, -1, -1]))
  end

  def test_ex2
    assert_equal([7, 3, -1], lastvisitor([3, 7, -1, -1, -1]))
  end

  def test_ex3
    assert_equal([2, 4, 2], lastvisitor([2, -1, 4, -1, -1]))
  end

  def test_ex4
    assert_equal([20, 30, 20], lastvisitor([10, 20, -1, 30, -1, -1]))
  end

  def test_ex5
    assert_equal([-1, -1, 5], lastvisitor([-1, -1, 5, -1]))
  end

end
