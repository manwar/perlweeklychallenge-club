#! /usr/bin/ruby

def factorcount(n)
  if n==1 then
    return 1
  end
  f=2
  s=Math.sqrt(n).floor
  if s*s==n then
    s-=1
    f+=1
  end
  2.upto(s) do |pf|
    if n % pf == 0 then
      f+= 2
    end
  end
  return f
end

def divisors(count,n)
  nn=n
  a=[]
  t=0
  while nn>0 do
    t+=1
    if factorcount(t)==count then
      a.push(t)
      nn-=1
    end
  end
  return a
end

require 'test/unit'

class TestDivisors < Test::Unit::TestCase

  def test_ex1
    assert_equal([24,30,40,42,54,56,66,70,78,88],divisors(8,10))
  end

end
