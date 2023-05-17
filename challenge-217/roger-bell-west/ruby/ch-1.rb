#! /usr/bin/ruby

def sortedmatrix(matrix)
  n = matrix.flatten
  n.sort!
  return n[2]
end

require 'test/unit'

class TestSortedmatrix < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, sortedmatrix([[3, 1, 2], [5, 2, 4], [0, 1, 3]]))
  end

  def test_ex2
    assert_equal(4, sortedmatrix([[2, 1], [4, 5]]))
  end

  def test_ex3
    assert_equal(0, sortedmatrix([[1, 0, 3], [0, 0, 0], [1, 2, 1]]))
  end

end
