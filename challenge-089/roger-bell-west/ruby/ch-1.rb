#! /usr/bin/ruby

def gs(n)
  tot=n-1
  2.upto(n-1) do |a|
    tot+=(a+1).upto(n).map{|x| a.gcd(x)}.reduce(:+)
  end
  return tot
end

require 'test/unit'

class TestGs < Test::Unit::TestCase

  def test_ex1
    assert_equal(3,gs(3))
  end

  def test_ex2
    assert_equal(7,gs(4))
  end

end
