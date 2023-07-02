#! /usr/bin/ruby

require 'test/unit'

def boxcoins(ints)
  mx = 0
  stack = [ [ ints, 0 ] ]
  while stack.length > 0 do
    x = stack.pop
    t = x[0]
    tot = x[1]
    if tot > mx then
      mx = tot
    end
    0.upto(t.length - 1) do |i|
      p = t[i]
      if i > 0 then
        p *= t[i - 1]
      end
      if i < t.length - 1 then
        p *= t[i + 1]
      end
      stot = tot + p
      tt = []
      0.upto(t.length - 1) do |ix|
        if i != ix then
          tt.push(t[ix])
        end
      end
      stack.push([tt, stot])
    end
  end
  return mx
end

class TestBoxcoins < Test::Unit::TestCase

  def test_ex1
    assert_equal(167, boxcoins([3, 1, 5, 8]))
  end

  def test_ex2
    assert_equal(10, boxcoins([1, 5]))
  end

end
