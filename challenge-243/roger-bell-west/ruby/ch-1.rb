#! /usr/bin/ruby

def reversepairs(a)
  return a.combination(2).find_all{|v| v[0] > 2 * v[1]}.length
end

require 'test/unit'

class TestReversepairs < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, reversepairs([1, 3, 2, 3, 1]))
  end

  def test_ex2
    assert_equal(3, reversepairs([2, 4, 3, 5, 1]))
  end

end
