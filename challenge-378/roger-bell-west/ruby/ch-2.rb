#! /usr/bin/ruby

def l2n(a)
  a0 = 'a'.ord
  t = 0
  a.chars.each do |c|
    t *= 10
    t += c.ord - a0
  end
  t
end

def sumofwords(a, b, c)
  l2n(a) + l2n(b) == l2n(c)
end

require 'test/unit'

class TestSumofwords < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, sumofwords('acb', 'cba', 'cdb'))
  end

  def test_ex2
    assert_equal(true, sumofwords('aab', 'aac', 'ad'))
  end

  def test_ex3
    assert_equal(false, sumofwords('bc', 'je', 'jg'))
  end

  def test_ex4
    assert_equal(true, sumofwords('a', 'aaaa', 'aa'))
  end

  def test_ex5
    assert_equal(false, sumofwords('c', 'd', 'h'))
  end

  def test_ex6
    assert_equal(true, sumofwords('gfi', 'hbf', 'bdhd'))
  end

end
