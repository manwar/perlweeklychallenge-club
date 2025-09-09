#! /usr/bin/ruby

def highestrow(a)
  a.map{|x| x.sum}.max
end

require 'test/unit'

class TestHighestrow < Test::Unit::TestCase

  def test_ex1
    assert_equal(16, highestrow([[4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9]]))
  end

  def test_ex2
    assert_equal(10, highestrow([[1, 5], [7, 3], [3, 5]]))
  end

  def test_ex3
    assert_equal(6, highestrow([[1, 2, 3], [3, 2, 1]]))
  end

  def test_ex4
    assert_equal(17, highestrow([[2, 8, 7], [7, 1, 3], [1, 9, 5]]))
  end

  def test_ex5
    assert_equal(100, highestrow([[10, 20, 30], [5, 5, 5], [0, 100, 0], [25, 25, 25]]))
  end

end
