#! /usr/bin/ruby

def pn(n)
  ns=n.to_s
  if ns==ns.reverse() then
    return 1
  else
    return 0
  end
end

require 'test/unit'

class TestPn < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,pn(1221))
  end

  def test_ex2
    assert_equal(0,pn(-101))
  end

  def test_ex3
    assert_equal(0,pn(90))
  end

end
