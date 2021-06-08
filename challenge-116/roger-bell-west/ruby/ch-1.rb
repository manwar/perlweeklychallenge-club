#! /usr/bin/ruby
# coding: utf-8

require 'test/unit'

def ns(n)
  ns=n.to_s
  l=ns.length
  1.upto((l/2).to_i) {|sl|
    i=sl
    e=[ns[0..sl-1].to_i]
    while 1
      if l-i==0 then
        break
      end
      e.push(e[-1]+1);
      es=e[-1].to_s;
      el=es.length
      if l-i < el ||
         ns[i..i+el-1] != es then
        e=[]
        break
      end
      i+=el
    end
    if e.length>0 then
      return e
    end
  }
  return [n]
end

class TestNs < Test::Unit::TestCase

  def test_ex1
    assert_equal([1,2,3,4],ns(1234))
  end
  def test_ex2
    assert_equal([9,10,11],ns(91011))
  end
  def test_ex3
    assert_equal([10203],ns(10203))
  end
  def test_ex4
    assert_equal([910,911],ns(910911))
  end
  def test_ex5
    assert_equal([9109119],ns(9109119))
  end
  
end
