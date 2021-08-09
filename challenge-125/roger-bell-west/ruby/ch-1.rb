#! /usr/bin/ruby

def pt(n)
  out=[]
  tri=[[3,4,5]]
  while (tri.length>0) do
    t=tri.shift
    0.upto(2) do |i|
      dm=n.divmod(t[i])
      if dm[1]==0 then
        out.push(t.map{|i| i*dm[0]})
      end
    end
    if t.min <= n then
      tri.push([
                 t[0]-2*t[1]+2*t[2],
                 2*t[0]-1*t[1]+2*t[2],
                 2*t[0]-2*t[1]+3*t[2],
               ])
      tri.push([
                 t[0]+2*t[1]+2*t[2],
                 2*t[0]+1*t[1]+2*t[2],
                 2*t[0]+2*t[1]+3*t[2],
               ])
      tri.push([
                 -t[0]+2*t[1]+2*t[2],
                 -2*t[0]+1*t[1]+2*t[2],
                 -2*t[0]+2*t[1]+3*t[2],
               ])
    end
  end
  return out
end

require 'test/unit'

class TestPt < Test::Unit::TestCase

  def test_ex1
    assert_equal([[3,4,5],[5,12,13]],pt(5))
  end

  def test_ex2
    assert_equal([[5,12,13],[13,84,85]],pt(13))
  end

  def test_ex3
    assert_equal([],pt(1))
  end
  
end
