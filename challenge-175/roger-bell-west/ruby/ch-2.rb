#! /usr/bin/ruby

require 'test/unit'

def eulertotient(n)
  et = 0
  1.upto(n) do |k|
    if n.gcd(k) == 1 then
      et += 1
    end
  end
  return et
end

def iteratedtotient(n0)
  p = 0
  n = n0
  while true do
    n = eulertotient(n)
    p += n
    if n == 1 then
      break
    end
    if p > n0 then
      break
    end
  end
  return p
end

def perfecttotient(ct)
  o = []
  n = 1
  while o.length < ct do
    n += 1
     if iteratedtotient(n) == n then
       o.push(n)
     end
  end
  return o
end

class TestPerfectTotient < Test::Unit::TestCase

  def test_ex1
    assert_equal([ 3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363,
                   471, 729, 2187, 2199, 3063, 4359, 4375, 5571 ],
                 perfecttotient(20))
  end

end
