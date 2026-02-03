#! /usr/bin/ruby

def strvalue(a)
  np = Regexp.new("^[0-9]+$")
  if a =~ np
    return a.to_i
  end
  a.length
end

def maxstrvalue(a)
  a.map {|x| strvalue(x)}.max
end

require 'test/unit'

class TestMaxstrvalue < Test::Unit::TestCase

  def test_ex1
    assert_equal(123, maxstrvalue(['123', '45', '6']))
  end

  def test_ex2
    assert_equal(4, maxstrvalue(['abc', 'de', 'fghi']))
  end

  def test_ex3
    assert_equal(99, maxstrvalue(['0012', '99', 'a1b2c']))
  end

  def test_ex4
    assert_equal(10, maxstrvalue(['x', '10', 'xyz', '007']))
  end

  def test_ex5
    assert_equal(2026, maxstrvalue(['hello123', '2026', 'perl']))
  end

end
