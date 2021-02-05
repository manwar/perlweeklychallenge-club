#! /usr/bin/ruby

def sip(n,t)
  if n[-1] < t
    return n.length
  end
  l=0
  h=n.length-1
  while (h-l > 1)
    m=((h+l)/2).floor
    if n[m]==t then
      return m
    elsif n[m] > t then
      h=m
    else
      l=m
    end
  end
  if n[l] >= t
    return l
  end
  return h
end

require 'test/unit'

class TestCc < Test::Unit::TestCase

  def test_ex1
    assert_equal(2,sip([1,2,3,4],3))
  end

  def test_ex2
    assert_equal(3,sip([1,3,5,7],6))
  end

  def test_ex3
    assert_equal(0,sip([12,14,16,18],10))
  end

  def test_ex4
    assert_equal(4,sip([11,13,15,17],19))
  end

end
