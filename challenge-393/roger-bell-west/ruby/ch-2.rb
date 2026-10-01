#! /usr/bin/ruby

require 'prime'

def primestep(a)
  g = a.chars.map{|c| c.ord}.sum
  pm = Prime.each.take_while { |p| p < g * 2 }
  lo = pm.select{|x| x <= g}[-1]
  hi = pm.select{|x| x > g}[0]
  [g - lo, hi - g].min
end

require 'test/unit'

class TestPrimestep < Test::Unit::TestCase

  def test_ex1
    assert_equal(9, primestep('hello'))
  end

  def test_ex2
    assert_equal(2, primestep('football'))
  end

  def test_ex3
    assert_equal(0, primestep('a'))
  end

  def test_ex4
    assert_equal(2, primestep('challenge'))
  end

  def test_ex5
    assert_equal(2, primestep('perl'))
  end

end
