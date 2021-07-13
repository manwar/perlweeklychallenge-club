#! /usr/bin/ruby

def ib(m,n)
  return m ^ (1 << (n-1))
end

require 'test/unit'

class TestIb < Test::Unit::TestCase

  def test_ex1
    assert_equal(8,ib(12,3))
  end
  
  def test_ex2
    assert_equal(26,ib(18,4))
  end
  
end
