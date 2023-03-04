#! /usr/bin/ruby

require 'test/unit'

require 'set'

def arraypairing(n)
  nl = n.length
  if nl % 2 == 1 then
    return 0
  end
  hl = nl.div(2)
  out = []
  0.upto(nl-1).to_a.combination(hl).each do |px|
    pa = px.map{|i| n[i]}
    ps = Set.new(px)
    pb = []
    n.each_with_index do |ni, i|
      if !ps.include?(i) then
        pb.push(ni)
      end
    end
    pa.permutation.each do |pp|
      s = 0
      0.upto(hl-1) do |i|
        s += [pp[i], pb[i]].min
      end
      out.push(s)
    end
  end
  return out.max
end

class TestArraypairing < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, arraypairing([1, 2, 3, 4]))
  end

#  def test_ex2
#    assert_equal(2, arraypairing([0, 2, 1, 3]))
#  end

end
