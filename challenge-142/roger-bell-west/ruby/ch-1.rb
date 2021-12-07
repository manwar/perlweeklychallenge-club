#! /usr/bin/ruby

def factor(n)
  if n==1 then
    return [1]
  end
  ff=[]
  s=Math.sqrt(n).floor
  if s*s==n then
    ff.push(s)
    s-=1
  end
  2.upto(s) do |pf|
    if n % pf == 0 then
      ff.push(n/pf)
      ff.unshift(pf)
    end
  end
  ff.push(n)
  ff.unshift(1)
  return ff
end

def dld(m,n)
  return factor(m).find_all{|i| i % 10 == n}.length()
end

require 'test/unit'

class TestDld < Test::Unit::TestCase

  def test_ex1
    assert_equal(2,dld(24,2))
  end

  def test_ex2
    assert_equal(2,dld(30,5))
  end

end
