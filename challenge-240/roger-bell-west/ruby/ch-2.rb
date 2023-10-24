#! /usr/bin/ruby

def buildarray(a)
  return a.map {|v| a[v]}
end

require 'test/unit'

class TestBuildarray < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 1, 2, 4, 5, 3], buildarray([0, 2, 1, 5, 3, 4]))
  end

  def test_ex2
    assert_equal([4, 5, 0, 1, 2, 3], buildarray([5, 0, 1, 2, 3, 4]))
  end

end
