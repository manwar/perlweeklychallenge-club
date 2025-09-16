#! /usr/bin/ruby

def peakpoint(a)
  h = 0
  o = 0
  a.each do |p|
    h += p
    o = [o, h].max
  end
  o
end

require 'test/unit'

class TestPeakpoint < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, peakpoint([-5, 1, 5, -9, 2]))
  end

  def test_ex2
    assert_equal(30, peakpoint([10, 10, 10, -25]))
  end

  def test_ex3
    assert_equal(6, peakpoint([3, -4, 2, 5, -6, 1]))
  end

  def test_ex4
    assert_equal(0, peakpoint([-1, -2, -3, -4]))
  end

  def test_ex5
    assert_equal(10, peakpoint([-10, 15, 5]))
  end

end
