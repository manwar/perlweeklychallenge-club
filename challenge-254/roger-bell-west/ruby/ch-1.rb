#! /usr/bin/ruby

def threepower(n0)
  if n0 == 0 then
    return false
  end
  n = n0.abs
  lo = 1
  hi = n.div(2)
  while true do
    t = (lo + hi).div(2)
    c = t * t * t
    if c == n then
      return true
    end
    if lo == t then
      return false
    end
    if c < n then
      lo = t
    else
      hi = t
    end
  end
end

require 'test/unit'

class TestThreepower < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, threepower(27))
  end

  def test_ex2
    assert_equal(false, threepower(0))
  end

  def test_ex3
    assert_equal(false, threepower(6))
  end

end
