#! /usr/bin/ruby

require 'test/unit'

require 'prime'

def isnumpal(c0)
  c = c0
  j = 0
  while c > 0 do
    ff = c.divmod(10)
    j = 10*j + ff[1]
    c = ff[0]
  end
  return c0 == j
end

def primepal(pmax)
  out = []
  Prime.each do |p|
    if p > pmax then
      break
    end
    if isnumpal(p) then
      out.push(p)
    end
  end
  return out
end

class TestPrimepal < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 3, 5, 7, 11, 101, 131, 151, 181, 191, 313, 353,
                  373, 383, 727, 757, 787, 797, 919, 929],
                 primepal(1000))
  end

end

