#! /usr/bin/ruby

def weakestrows(a)
  p = (0...a.length())
  b = a.map { |n| n.sum }
  p = p.sort_by { |x| b[x] }
  return p
end

require 'test/unit'

class TestWeakestrows < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 0, 3, 1, 4], weakestrows([[1, 1, 0, 0, 0], [1, 1, 1, 1, 0], [1, 0, 0, 0, 0], [1, 1, 0, 0, 0], [1, 1, 1, 1, 1]]))
  end

  def test_ex2
    assert_equal([0, 2, 3, 1], weakestrows([[1, 0, 0, 0], [1, 1, 1, 1], [1, 0, 0, 0], [1, 0, 0, 0]]))
  end

end
