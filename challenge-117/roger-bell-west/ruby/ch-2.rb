#! /usr/bin/ruby
# coding: utf-8

require 'test/unit'

require 'set'

def fpp(n)
  o=Set.new
  chain=[["",0,0]]
  lim=(n-1)*4
  if n==1 then
    lim=2
  end
  while chain.length() > 0
    p=chain.pop
    x=p[1]
    y=p[2]
    if y >= lim then
      o.add(p[0])
    else
      mxx=y+1
      if y >= n then
        mxx=lim-y-1
      end
      0.upto(2) do |txi|
        tx=x-1+txi
        if tx>=0 && tx<=mxx then
          if txi==0 then
            chain.push([p[0]+'H',x-1,y+1])
          elsif txi==1 then
            chain.push([p[0]+'R',x,y+2])
          else
            chain.push([p[0]+'L',x+1,y+1])
          end
        end
      end
    end
  end
  return o.to_a.sort
end

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
    assert_equal(['LHLH','LHR','LLHH','LRH','RLH','RR'],fpp(2))
  end
  
  def test_ex2
    assert_equal(['LH','R'],fpp(1))
  end
  
end
