#! /usr/bin/ruby

require 'test/unit'

require 'prime'

def countprimes(l)
  return Prime.each.take_while { |p| p <= l }.length
end

class TestCountprimes < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, countprimes(10))
  end

  def test_ex2
    assert_equal(0, countprimes(1))
  end

  def test_ex3
    assert_equal(8, countprimes(20))
  end

end
