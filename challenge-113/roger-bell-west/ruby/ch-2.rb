#! /usr/bin/ruby

def rbt(ti)
  s=0
  ti.each {|n|
    if n>0 then
      s += n
    end
  }
  to=[]
  ti.each {|n|
    if n>0 then
      to.push(s-n)
    else
      to.push(n)
    end
  }
  return to
end

require 'test/unit'

class TestRbt < Test::Unit::TestCase

  def test_ex1
    assert_equal([27,26,25,24,-1,23,22,-1,21],rbt([1,2,3,4,-1,5,6,-1,7]))
  end
  
end
