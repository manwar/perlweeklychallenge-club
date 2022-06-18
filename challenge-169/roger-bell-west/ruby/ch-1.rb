#! /usr/bin/ruby

require 'test/unit'

require 'set'
require 'prime'

def brilliant(ct)
  base = 1
  out = Set.new
  while true do
    b10 = base * 10
    pl = Prime.each.take_while {|i| i <= b10}.find_all {|i| i >= base}
    0.upto(pl.length-1) do |ai|
      ai.upto(pl.length-1) do |bi|
        out.add(pl[ai] * pl[bi])
      end
    end
    if out.length >= ct then
       break
    end
    base *= 10
  end
  return out.to_a.sort[0..ct-1]
end

class TestBrilliant < Test::Unit::TestCase

  def test_ex1
    assert_equal([4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169,
                  187, 209, 221, 247, 253, 289, 299],
                 brilliant(20))
  end

end
