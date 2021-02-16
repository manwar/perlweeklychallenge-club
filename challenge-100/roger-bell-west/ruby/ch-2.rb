#! /usr/bin/ruby

def ts(inp)
  b=Array.new
  n=0
  i=0
  s=inp[0][0]
  r=Array.new
  while (1)
    if b.length>0 then
      t=b.pop;
      (n,i,s)=t;
    end
    if n < inp.length-1 then
      n += 1
      i.upto(i+1) do |ix|
        b.push([n,ix,s+inp[n][ix]])
      end
    else
      r.push(s)
    end
    if b.length==0 then
      break
    end
  end
  return r.min
end

require 'test/unit'

class TestPm < Test::Unit::TestCase

  def test_ex1
    assert_equal(8,ts([[1],[2,4],[6,4,9],[5,1,7,2]]))
  end

  def test_ex2
    assert_equal(7,ts([[3],[3,1],[5,2,3],[4,3,1,3]]))
  end

end
