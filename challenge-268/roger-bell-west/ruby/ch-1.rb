#! /usr/bin/ruby

def magicnumber(a, b)
  return b.min - a.min
end

require 'test/unit'

class TestMagicnumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, magicnumber([3, 7, 5], [9, 5, 7]))
  end

  def test_ex2
    assert_equal(3, magicnumber([1, 2, 1], [5, 4, 4]))
  end

  def test_ex3
    assert_equal(3, magicnumber([2], [5]))
  end

end
