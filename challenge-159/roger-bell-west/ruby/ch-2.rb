#! /usr/bin/ruby

require 'test/unit'

require 'set'
require 'prime'

def moebius(n)
  z=0
  for vv in n.prime_division do
    if vv[1] > 1 then
      return 0
    end
    z += 1
  end
  if z % 2 == 0 then
    return 1
  end
  return -1
end

class TestMoebius < Test::Unit::TestCase

  def test_ex1
    assert_equal(-1,moebius(5))
  end

  def test_ex2
    assert_equal(1,moebius(10))
  end

  def test_ex3
    assert_equal(0,moebius(20))
  end

end
