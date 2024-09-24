#! /usr/bin/ruby

def closestpalindrome(a)
  n = a.to_i
  delta = -1
  while (true) do
    q = (n + delta).to_s
    if q == q.reverse
      return q
    end
    delta = -delta
    if delta < 0
      delta -= 1
    end
  end
end

require 'test/unit'

class TestClosestpalindrome < Test::Unit::TestCase

  def test_ex1
    assert_equal('121', closestpalindrome('123'))
  end

  def test_ex2
    assert_equal('1', closestpalindrome('2'))
  end

  def test_ex3
    assert_equal('1441', closestpalindrome('1400'))
  end

  def test_ex4
    assert_equal('999', closestpalindrome('1000'))
  end

end
