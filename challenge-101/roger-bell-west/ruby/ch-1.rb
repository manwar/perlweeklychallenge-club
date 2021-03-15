#! /usr/bin/ruby

def pas(aa)
  a=aa.reverse
  n=a.length
  f2=Integer.sqrt(n)
  f1=0
  while 1
    if n % f2 == 0
      f1=n/f2
      break
    end
    f2 -= 1
  end
  out=Array.new
  1.upto(f2) do
    out.push([0] * f1)
  end
  x=-1
  y=0
  maxx=f1-1
  maxy=f2-1
  minx=0
  miny=1
  catch :arr do
    while 1
      while x < maxx
        x += 1
        out[y][x]=a.pop()
        if a.length==0 then
          throw :arr
        end
      end
      maxx -= 1
      while y < maxy
        y += 1
        out[y][x]=a.pop()
        if a.length==0 then
          throw :arr
        end
      end
      maxy -= 1
      while x > minx
        x -= 1
        out[y][x]=a.pop()
        if a.length==0 then
          throw :arr
        end
      end
      minx += 1
      while y > miny
        y -= 1
        out[y][x]=a.pop()
        if a.length==0 then
          throw :arr
        end
      end
      miny += 1
    end
  end
  return out
end

require 'test/unit'

class TestPas < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1,2],[4,3]],pas((1..4).to_a))
  end

  def test_ex2
    assert_equal([[1,2,3],[6,5,4]],pas((1..6).to_a))
  end

  def test_ex3
    assert_equal([[1,2,3,4],[10,11,12,5],[9,8,7,6]],pas((1..12).to_a))
  end

end
