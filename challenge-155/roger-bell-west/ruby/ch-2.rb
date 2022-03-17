#! /usr/bin/ruby

require 'test/unit'

require 'set'
require 'prime'

def pisano(n)
  a=1
  for vv in n.prime_division do
    nn=vv[0] ** vv[1]
    t=1
    x=[1,1]
    while (x[0] != 0 || x[1] != 1) do
      t += 1
      x=[x[1], (x[0]+x[1]) % nn]
    end
    a=a.lcm(t)
  end
  return a
end

class TestPisano < Test::Unit::TestCase

  def test_ex1
    assert_equal(8,pisano(3))
  end

  def test_ex2
    assert_equal(24,pisano(6))
  end

end
