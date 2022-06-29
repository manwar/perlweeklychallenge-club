#! /usr/bin/ruby

require 'test/unit'

def abundant(n)
  if n==1 then
    return false
  end
  ff = 1
  s=Integer.sqrt(n)
  if s * s == n then
    ff += s
    s -= 1
  end
  2.upto(s) do |pf|
    if n % pf == 0 then
      ff += pf
      ff += n.div(pf)
      if ff > n then
        return true
      end
    end
  end
  return false
end

def oddabundant(ct)
  n = 1
  o = []
  while true do
    if abundant(n) then
      o.push(n)
      if o.length >= ct then
        break
      end
    end
    n += 2
  end
  return o
end

class TestOddAbundant < Test::Unit::TestCase

  def test_ex1
    assert_equal([945, 1575, 2205, 2835, 3465, 4095, 4725, 5355, 5775, 5985,
                  6435, 6615, 6825, 7245, 7425, 7875, 8085, 8415, 8505,
                  8925],
                 oddabundant(20))
  end

end
