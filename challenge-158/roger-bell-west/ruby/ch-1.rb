#! /usr/bin/ruby

require 'test/unit'

require 'set'
require 'prime'

def digitsum(x0)
  s=0
  x=x0
  while x > 0 do
    x,ss=x.divmod(10)
    s += ss
  end
  return s
end

def additiveprimes(mx)
  o=[]
  ps=Set.new
  Prime.each do |q|
    if q > mx then
      break
    end
    ps.add(q)
    if ps.include?(digitsum(q)) then
      o.push(q)
    end
  end
  return o
end

class TestAdditiveprimes < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83,
                  89],additiveprimes(100))
  end

end
