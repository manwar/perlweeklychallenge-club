#! /usr/bin/ruby

require 'test/unit'

def divisors(n)
  ff=[1]
  if n==1 then
    return ff
  end
  s=Integer.sqrt(n)
  if s * s == n then
    ff.push(s)
    s -= 1
  end
  2.upto(s) do |pf|
    if n % pf == 0 then
      ff.push(pf)
      ff.push(n.div(pf))
    end
  end
  return ff
end

def is_weird(n)
  dd=divisors(n)
  if dd.inject(:+) <= n then
    return false
  end
  1.upto((1 << dd.length)-1) do |mask|
    ss=0
    dd.each_with_index do |d,i|
      if mask & (1 << i) then
        ss += d
        if ss > n then
          break
        end
      end
      if ss == n then
        return false
      end
    end
  end
  return true
end

class TestWeird < Test::Unit::TestCase

  def test_ex1
    assert_equal(false,is_weird(12))
  end

  def test_ex2
    assert_equal(false,is_weird(13))
  end

  def test_ex3
    assert_equal(true,is_weird(70))
  end

end
