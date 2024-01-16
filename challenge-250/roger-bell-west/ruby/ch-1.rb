#! /usr/bin/ruby

def smallestindex(a)
  a.each_with_index do |n, i|
    if n % 10 == i then
      return i
    end
  end
  return -1
end

require 'test/unit'

class TestSmallestindex < Test::Unit::TestCase

  def test_ex1
    assert_equal(0, smallestindex([0, 1, 2]))
  end

  def test_ex2
    assert_equal(2, smallestindex([4, 3, 2, 1]))
  end

  def test_ex3
    assert_equal(-1, smallestindex([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]))
  end

end
