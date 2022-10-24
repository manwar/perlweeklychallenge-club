#! /usr/bin/ruby

require 'test/unit'

def totalzero(aa, bb)
  if aa == 0 && bb == 0 then
    return 0
  end
  a = aa
  b = bb
  ct = 1
  while true do
    if a == b then
      return ct
    end
    ct += 1
    if a > b then
         a -= b
    else
      b -= a
    end
  end
end

class TestTotalzero < Test::Unit::TestCase

  def test_ex1
    assert_equal(5, totalzero(5, 4))
  end

  def test_ex2
    assert_equal(3, totalzero(4, 6))
  end

  def test_ex3
    assert_equal(4, totalzero(2, 5))
  end

  def test_ex4
    assert_equal(3, totalzero(3, 1))
  end

  def test_ex5
    assert_equal(5, totalzero(7, 4))
  end
end
