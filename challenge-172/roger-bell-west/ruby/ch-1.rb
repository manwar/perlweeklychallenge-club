#! /usr/bin/ruby

require 'test/unit'

require 'prime'
require 'set'

def primepartition(n, divs)
  pl = Prime.each.take_while { |p| p <= n }
  p = [[]]
  while p.length > 0 do
    pa = p.pop
    if pa.length == divs then
      if pa.inject(:+) == n then
        return pa
      end
    else
      px = Set.new(pa)
      pl.each do |pq|
        if !px.include?(pq) then
          pb = pa[0..-1]
          pb.push(pq)
          p.push(pb)
        end
      end
    end
  end
  return [n]
end

class TestPrimepartition < Test::Unit::TestCase

  def test_ex1
    assert_equal([13, 5],primepartition(18,2))
  end

  def test_ex2
    assert_equal([11, 5, 3],primepartition(19,3))
  end

end
