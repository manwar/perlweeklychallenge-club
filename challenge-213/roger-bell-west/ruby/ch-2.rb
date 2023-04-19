#! /usr/bin/ruby

require 'set'

def shortestroute(r0, origin, destination)
  r = Hash.new
  r0.each do |rt|
    rt.each_cons(2) do |rp|
      if !r.has_key?(rp[0]) then
        r[rp[0]] = Set.new
      end
      r[rp[0]].add(rp[1])
      if !r.has_key?(rp[1]) then
        r[rp[1]] = Set.new
      end
      r[rp[1]].add(rp[0])
    end
  end
  out = []
  stack = [[origin]]
  while stack.length > 0 do
    s = stack.shift
    l = s[-1]
    if l == destination then
      out = s
      break
    else
      (r[l] - Set.new(s)).each do |pd|
        q = s[0..-1]
        q.push(pd)
        stack.push(q)
      end
    end
  end
  return out
end

require 'test/unit'

class TestShortestroute < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 2, 6, 7], shortestroute([[1, 2, 6], [5, 6, 7]], 1, 7))
  end

  def test_ex2
    assert_equal([], shortestroute([[1, 2, 3], [4, 5, 6]], 2, 5))
  end

  def test_ex3
    assert_equal([1, 2, 3, 8, 7], shortestroute([[1, 2, 3], [4, 5, 6], [3, 8, 9], [7, 8]], 1, 7))
  end

end
