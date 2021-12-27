#! /usr/bin/ruby

def factorpairs(n)
  if n==1 then
    return [2]
  end
  ff=[]
  s=Math.sqrt(n).floor
  if s*s==n then
    ff.push(s*2)
    s-=1
  end
  2.upto(s) do |pf|
    if n % pf == 0 then
      ff.push(n/pf+pf)
    end
  end
  ff.push(1+n)
  return ff
end

def is_stealthy(n)
  p=factorpairs(n)
  if p.length()==1 then
    return false
  end
  0.upto(p.length()-2) do |ix|
    ix.upto(p.length()-1) do |iy|
      if (p[ix]-p[iy]).abs==1 then
        return true
      end
    end
  end
  return false
end

require 'test/unit'

class TestIs_Stealthy < Test::Unit::TestCase

  def test_ex1
    assert_equal(true,is_stealthy(36))
  end

  def test_ex2
    assert_equal(true,is_stealthy(12))
  end

  def test_ex3
    assert_equal(false,is_stealthy(6))
  end

end
