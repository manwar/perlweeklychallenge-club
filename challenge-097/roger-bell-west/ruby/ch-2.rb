#! /usr/bin/ruby

def diff(a,b)
  aa=a.split('')
  bb=b.split('')
  d=0
  0.upto(aa.length()-1) do |i|
    if a[i] != b[i]
      d+=1
    end
  end
  return d
end

def bs(b,s)
  bb=Array.new
  i=0
  while (i < b.length) do
    bb.push(b.slice(i,s))
    i+=s
  end
  if bb[-1].length != s then
    return -1
  end
  mc=-1
  cost=Hash.new
  0.upto(bb.length-2) do |x|
    if !cost.has_key?(x) then
      cost[x]=Hash.new
    end
    cost[x][x]=0
    x+1.upto(bb.length-1) do |y|
      cost[x][y]=diff(bb[x],bb[y])
      if !cost.has_key?(y) then
        cost[y]=Hash.new
      end
      cost[y][x]=cost[x][y]
    end
    tc=0.upto(bb.length-1).map{|i| cost[x][i]}.sum()
    if mc==-1 or tc < mc then
      mc=tc
    end
  end
  return mc
end

require 'test/unit'

class TestBs < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,bs('101100101',3))
  end

  def test_ex2
    assert_equal(4,bs('00011011',2))
  end

end
