#! /usr/bin/ruby

def cs(i)
  a=0
  b=1
  c=0
  1.upto(i) do
    c=a+b
    a=b
    b=c
  end
  return c
end
      
require 'test/unit'

class TestCs < Test::Unit::TestCase

  def test_ex1
    assert_equal(3,cs(3))
  end
  
  def test_ex2
    assert_equal(5,cs(4))
  end
  
  def test_ex3
    assert_equal(10946,cs(20))
  end
  
end
