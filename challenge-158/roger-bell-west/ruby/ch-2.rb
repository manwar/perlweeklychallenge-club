#! /usr/bin/ruby

require 'test/unit'

require 'set'
require 'prime'

def cuban1(mx)
  o=[]
  1.upto(mx) do |y|
    q=3*y*(y+1)+1
    if q > mx then
      break
    end
    if q.prime? then
      o.push(q)
    end
  end
  return o
end

class TestCuban1 < Test::Unit::TestCase

  def test_ex1
    assert_equal([7, 19, 37, 61, 127, 271, 331, 397, 547, 631,
                  919],cuban1(1000))
  end

end
