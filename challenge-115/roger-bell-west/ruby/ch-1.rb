#! /usr/bin/ruby
# coding: utf-8

require 'test/unit'

require 'set'

def sc(*n)
  m=[]
  i=Hash.new
  n.each {|t|
    m.push(t[-1])
    ss=t[0]
    if i.has_key?(ss) then
      i[ss].push(m.length-1)
    else
      i[ss]=[m.length-1]
    end
  }
  chain=[[0]]
  while (chain.length>0)
    stub=chain.pop
    v=Set.new(0.upto(n.length-1))
    stub.map{|x| v.delete(x)}
    if v.length>0 then
      if i.has_key?(m[stub[-1]]) then
        x=i[m[stub[-1]]].find_all {|x| v.include?(x)}
        x.each {|xx|
          s=stub.dup
          s.push(xx)
          chain.push(s)
        }
      end
    else
      if i.has_key?(m[stub[-1]]) and i[m[stub[-1]]][0]==0 then
        return 1
      end
    end
  end
  return 0
end

class TestSc < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,sc('abc','dea','cd'))
  end
  def test_ex2
    assert_equal(0,sc('ade','cbd','fgh'))
  end
  def test_ex3
    assert_equal(0,sc('abc','dea','fgh','hif'))
  end
  def test_ex4
    assert_equal(1,sc('abc','dec','cfa','cgd'))
  end
  def test_ex5
    assert_equal(0,sc('abc','def','cd'))
  end
  
end
