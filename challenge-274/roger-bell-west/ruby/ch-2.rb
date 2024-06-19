#! /usr/bin/ruby

require 'set'

def busroute(a)
  route = []
  a.each do |rt|
    ri = Hash.new
    (interval, offset, duration) = rt
    start = offset
    while true do
      if start > 60 + offset then
        break
      end
      ri[start] = start + duration
      start += interval
    end
    route.push(ri)
  end
  out = []
  0.upto(59) do |t|
    best = Set.new
    at = -1
    nxt = Set.new
    ndt = -1
    route.each_with_index do |r, i|
      nb = r.keys.select { |n| n >= t }.min
      nt = r[nb]
      if at == -1 || nt < at
        best = Set.new
        at = nt
      end
      if nt <= at
        best.add(i)
      end
      if ndt == -1 || nb < ndt
        nxt = Set.new
        ndt = nb
      end
      if nb <= ndt
        nxt.add(i)
      end
    end
    if (best & nxt) .length == 0
      out.push(t)
    end
  end
  return out
end

require 'test/unit'

class TestBusroute < Test::Unit::TestCase

  def test_ex1
    assert_equal([36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47], busroute([[12, 11, 41], [15, 5, 35]]))
  end

  def test_ex2
    assert_equal([0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59], busroute([[12, 3, 41], [15, 9, 35], [30, 5, 25]]))
  end

end
