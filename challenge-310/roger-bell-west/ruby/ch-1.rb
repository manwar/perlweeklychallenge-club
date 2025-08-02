#! /usr/bin/ruby

require 'set'

def arraysintersection(a)
  s = a[0].to_set
  a.drop(1).each do |b|
    s = s & b.to_set
  end
  s.to_a.sort
end

require 'test/unit'

class TestArraysintersection < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 4], arraysintersection([[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]]))
  end

  def test_ex2
    assert_equal([2], arraysintersection([[1, 0, 2, 3], [2, 4, 5]]))
  end

  def test_ex3
    assert_equal([], arraysintersection([[1, 2, 3], [4, 5], [6]]))
  end

end
