#! /usr/bin/ruby

require 'test/unit'

def ci(a)
  o=[]
  1.upto(a.length-1) do |i|
    0.upto(i-1) do |j|
      if (a[i][0] >= a[j][0] && a[i][0] <= a[j][1]) ||
         (a[i][1] >= a[j][0] && a[i][1] <= a[j][1]) ||
         (a[i][0] <= a[j][0] && a[i][1] >= a[j][1]) then
        o.push(a[i])
        break
      end
    end
  end
  return o
end

class TestCi < Test::Unit::TestCase

  def test_ex1
    assert_equal([[3,5],[3,20]],ci([[1,4],[3,5],[6,8],[12,13],[3,20]]))
  end

  def test_ex2
    assert_equal([[6,9]],ci([[3,4],[5,7],[6,9],[10,12],[13,15]]))
  end
  
end
