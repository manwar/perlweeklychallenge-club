#! /usr/bin/ruby

require 'prime'

def omega(a, mode)
  pf = a.prime_division
  if mode == 0
    return pf.size
  else
    return pf.map {|x| x[1]}.sum
  end
end

require 'test/unit'

class TestOmega < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, omega(100061, 0))
  end

  def test_ex2
    assert_equal(3, omega(971088, 0))
  end

  def test_ex3
    assert_equal(6, omega(63640, 1))
  end

  def test_ex4
    assert_equal(2, omega(988841, 1))
  end

  def test_ex5
    assert_equal(2, omega(211529, 0))
  end

end
