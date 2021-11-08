#! /usr/bin/ruby

def aos(m)
  n=0
  t=0
  o=[]
  m.each {|i|
    t+=i
    n+=1
    o.push(t/n)
  }
  return o
end

require 'test/unit'

class TestAos < Test::Unit::TestCase

  def test_ex1
    assert_equal([10, 15, 20, 25, 30, 35, 40, 45, 50],aos([10, 20, 30, 40, 50, 60, 70, 80, 90]))
  end
  
end
