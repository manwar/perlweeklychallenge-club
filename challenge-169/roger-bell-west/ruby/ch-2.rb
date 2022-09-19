#! /usr/bin/ruby

require 'test/unit'

require 'set'
require 'prime'

def achilles(ct)
  o = []
  n = 1
  while true do
    n += 1
    pv = n.prime_division.collect {|i| i[1]}
    if pv.length > 1 &&
       pv.min >=2 &&
       pv.inject { |a,b| a.gcd(b) } == 1 then
      o.push(n)
      if o.length >= ct then
        break
      end
    end
  end
  return o
end

class TestAchilles < Test::Unit::TestCase

  def test_ex1
    assert_equal([72, 108, 200, 288, 392, 432, 500, 648, 675, 800,
                  864, 968, 972, 1125, 1152, 1323, 1352, 1372, 1568,
                  1800],
                 achilles(20))
  end

end
