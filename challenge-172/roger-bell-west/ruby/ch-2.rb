#! /usr/bin/ruby

require 'test/unit'

def fivenumber(n0)
  n = n0.sort
  nl = n.length-1
  o = [n[0]]
  1.upto(3) do |quartile|
    bx = quartile * nl
    base = bx.div(4)
    v = n[base]
    if bx % 4 != 0 then
      v = (n[base] + n[base+1]) / 2.0
    end
    o.push(v)
  end
  o.push(n[-1])
  return o
end

class TestFivenumber < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 0.5, 7.5, 44, 63],
                 fivenumber([0, 0, 1, 2, 63, 61, 27, 13]))
  end

end
