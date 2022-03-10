#! /usr/bin/ruby

require 'test/unit'

require 'set'
require 'prime'

def nthprimelimit(n)
  m=15
  if n >= 6 then
    m=1+n*Math.log(n*Math.log(n)).floor
  end
  return m
end

def fortunate(ct)
  o=Set.new
  ll=[]
  ph=1
  pl=nthprimelimit(ct*2)
  Prime.each do |p|
    if p > pl then
      break
    end
    if o.length >= ct then
      if p >= o.max then
        break
      end
    end
    ph *= p
    l = p + 1
    while !( (l+ph).prime? ) do
      l += 1
    end
    o.add(l)
    if o.length > ct then
      ll=o.to_a.sort
      ll=ll[0,ct]
      o=Set.new(ll)
    end
  end
  return ll
end

class TestFortunate < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 5, 7, 13, 17, 19, 23, 37],fortunate(8))
  end

end
