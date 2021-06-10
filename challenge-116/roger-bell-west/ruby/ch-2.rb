#! /usr/bin/ruby
# coding: utf-8

require 'test/unit'

def sos(n)
  t=0
  n.to_s.chars {|i|
    ii=i.to_i
    t+=ii*ii
  }
  s=Integer.sqrt(t)
  if s*s==t then
    return 1
  end
  return 0
end


class TestSos < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,sos(34))
  end
  
  def test_ex2
    assert_equal(1,sos(50))
  end
  
  def test_ex3
    assert_equal(0,sos(52))
  end
  
end
