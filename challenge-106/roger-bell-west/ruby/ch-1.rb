#! /usr/bin/ruby

def mg(*aa)
  a=aa.sort()
  g=0
  0.upto(a.length()-2) do |i|
    d=(a[i]-a[i+1]).abs
    if d>g then
      g=d
    end
  end
  return g
end

require 'test/unit'

class TestMg < Test::Unit::TestCase

  def test_ex1
    assert_equal(4,mg(2,9,3,5))
  end

  def test_ex2
    assert_equal(5,mg(1,3,8,2,0))
  end

  def test_ex3
    assert_equal(0,mg(5))
  end

end
