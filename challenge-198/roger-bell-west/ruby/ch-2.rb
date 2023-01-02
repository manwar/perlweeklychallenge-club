#! /usr/bin/ruby

require 'test/unit'

require 'prime'

def primecount(l)
  return Prime.each.take_while { |p| p < l }.length
end

class TestPrimecount < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, primecount(10))
  end

  def test_ex2
    assert_equal(6, primecount(15))
  end

  def test_ex3
    assert_equal(0, primecount(1))
  end

  def test_ex4
    assert_equal(9, primecount(25))
  end

end
