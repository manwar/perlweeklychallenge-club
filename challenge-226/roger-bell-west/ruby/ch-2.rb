#! /usr/bin/ruby

require 'set'

def zeroarray(a)
  s = Set.new(a)
  s.delete(0)
  return s.length
end

require 'test/unit'

class TestZeroarray < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, zeroarray([1, 5, 0, 3, 5]))
  end

  def test_ex2
    assert_equal(0, zeroarray([0]))
  end

  def test_ex3
    assert_equal(4, zeroarray([2, 1, 4, 0, 3]))
  end

end
