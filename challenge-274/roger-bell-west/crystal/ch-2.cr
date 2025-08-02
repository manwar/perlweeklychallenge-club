#! /usr/bin/crystal

def busroute(a)
  route = [] of Hash(Int32, Int32)
  a.each do |rt|
    ri = Hash(Int32, Int32).new
    interval, offset, duration = rt
    start = offset
    while true
      if start > 60 + offset
        break
      end
      ri[start] = start + duration
      start += interval
    end
    route.push(ri)
  end
  out = [] of Int32
  0.upto(59) do |t|
    best = Set(Int32).new
    at = -1
    nxt = Set(Int32).new
    ndt = -1
    route.each_with_index do |r, i|
      nb = r.keys.select { |n| n >= t }.min
      nt = r[nb]
      if at == -1 || nt < at
        best.clear
        at = nt
      end
      if nt <= at
        best.add(i)
      end
      if ndt == -1 || nb < ndt
        nxt.clear
        ndt = nb
      end
      if nb <= ndt
        nxt.add(i)
      end
    end
    if (best & nxt) .size == 0
      out.push(t)
    end
  end
  out
end

require "spec"
describe "busroute" do
  it "test_ex1" do
    busroute([[12, 11, 41], [15, 5, 35]]).should eq [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
  end
  it "test_ex2" do
    busroute([[12, 3, 41], [15, 9, 35], [30, 5, 25]]).should eq [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59]
  end
end
