#! /usr/bin/ruby

def bs(n)
  o=[]
  p=[[]]
  while p.length() > 0 do
    s=p.pop()
    t=s.sum()
    if t==n then
      o.push(s)
    else
      1.upto([3,n-t].min()) {|i|
        q=s.dup
        q.push(i)
        p.push(q)
      }
    end
  end
  o.reverse!()
  return o
end

require 'test/unit'

class TestBs < Test::Unit::TestCase

  def test_ex1
    assert_equal([
                   [1,1,1,1],
                   [1,1,2],
                   [1,2,1],
                   [1,3],
                   [2,1,1],
                   [2,2],
                   [3,1]
                 ],bs(4))
  end

  def test_ex2
    assert_equal([
                   [1,1,1,1,1],
                   [1,1,1,2],
                   [1,1,2,1],
                   [1,1,3],
                   [1,2,1,1],
                   [1,2,2],
                   [1,3,1],
                   [2,1,1,1],
                   [2,1,2],
                   [2,2,1],
                   [2,3],
                   [3,1,1],
                   [3,2]
                 ],bs(5))
  end
  
end
