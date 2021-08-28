#! /usr/bin/ruby

require 'test/unit'

def cn(n)
  k=n
  digits=[]
  while (k>0)
    kd=k.divmod(10)
    k=kd[0]
    if kd[1]==1 then
      digits=Array.new(digits.length(),8)
    end
    if kd[1]>0 then
      kd[1] -= 1
    end
    digits.push(kd[1])
  end
  tc=0
  (digits.length()-1).downto(0) do |i|
    tc *= 9
    tc += digits[i]
  end
  return tc
end

class TestPt < Test::Unit::TestCase

  def test_ex1
    assert_equal(8,cn(15))
  end

  def test_ex2
    assert_equal(13,cn(25))
  end

  def test_ex3
    assert_equal(6560,cn(10000))
  end

  def test_ex4
    assert_equal(43046720,cn(100000000))
  end
  
end
