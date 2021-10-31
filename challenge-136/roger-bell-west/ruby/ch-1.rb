#! /usr/bin/ruby

def ispower2(n)
  if n<2 then
    return false
  end
  return (n & (n-1))==0
end

def twofriendly(m,n)
  return ispower2(m.gcd(n))?1:0;
end

require 'test/unit'

class TestTwofriendly < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,twofriendly(8,24))
  end

  def test_ex2
    assert_equal(0,twofriendly(26,39))
  end

  def test_ex3
    assert_equal(1,twofriendly(4,10))
  end

  def test_ex4
    assert_equal(0,twofriendly(1,2))
  end

end
