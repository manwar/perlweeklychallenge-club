#! /usr/bin/ruby

def foursquare(src)
  sol=[]
  src.permutation do |t|
    b=t[1]+t[2]+t[3]
    if t[0]+t[1]==b then
      c=t[3]+t[4]+t[5]
      if b==c && c == t[5]+t[6] then
        sol=t
        break
      end
    end
  end
  return sol
end

require 'test/unit'

class TestFoursquare < Test::Unit::TestCase

  def test_ex1
    q=foursquare([1,2,3,4,5,6,7])
    assert_equal(q[0],q[2]+q[3])
    assert_equal(q[1]+q[2],q[4]+q[5])
    assert_equal(q[3]+q[4],q[6])
  end

end
