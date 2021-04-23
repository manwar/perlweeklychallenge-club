#! /usr/bin/ruby

def ds(n,d)
  quotient=sprintf('%d.',n/d)
  c=10*(n % d)
  while c>0 && c < d
    c *= 10
    quotient += "0"
  end
  digits=Array.new
  passed=Hash.new
  i=0
  while 1
    if passed.has_key?(c) then
      cycle=digits[passed[c]..-1]
      result=quotient
      if passed[c]>0 then
        result += digits[0..passed[c]-1].join('')
      end
      if cycle.length>1 || cycle[0] != 0 then
        result += "(" + cycle.join('') + ")"
      end
      if result[-1] == '.' then
        result[-1]=''
      end
      return result
    end
    q=(c/d).floor
    r=c % d
    passed[c]=i
    digits.push(q)
    i+=1
    c=10*r
  end
end

require 'test/unit'

class TestDs < Test::Unit::TestCase

  def test_ex1
    assert_equal("0.(3)",ds(1,3))
  end

  def test_ex2
    assert_equal("0.5",ds(1,2))
  end

  def test_ex3
    assert_equal("0.0(75)",ds(5,66))
  end

end
