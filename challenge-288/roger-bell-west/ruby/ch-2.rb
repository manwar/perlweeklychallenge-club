#! /usr/bin/ruby

require 'set'

def encode(x, y)
  return x * 1e6 + y
end

def decode(c)
  return c.divmod(1e6)
end

def contiguousblock(a)
  y = a.length
  x = a[0].length
  starts = Set.new
  0.upto(x - 1) do |cx|
    0.upto(y - 1) do |cy|
      starts.add(encode(cx, cy))
    end
  end
  maxblock = 0
  while starts.length > 0 do
    start = starts.to_a[0]
    cstart = decode(start)
    queue = []
    visited = Set.new
    visited.add(start)
    queue.push(start)
    while queue.length > 0 do
      here = queue.shift
      chere = decode(here)
      [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |delta|
        if (delta[0] >= 0 || chere[0] > 0) &&
           (delta[0] <= 0 || chere[0] < x - 1) &&
           (delta[1] >= 0 || chere[1] > 0) &&
           (delta[1] <= 0 || chere[1] < y - 1)
          cthere = [chere[0] + delta[0], chere[1] + delta[1]]
          there = encode(*cthere)
          if (!visited.include?(there) &&
              a[cthere[1]][cthere[0]] == a[cstart[1]][cstart[0]])
            visited.add(there)
            queue.push(there)
          end
        end
      end
    end
    size = visited.length
    if (size > maxblock)
      maxblock = size
    end
    starts -= visited
  end
  return maxblock
end

require 'test/unit'

class TestContiguousblock < Test::Unit::TestCase

  def test_ex1
    assert_equal(11, contiguousblock([['x', 'x', 'x', 'x', 'o'], ['x', 'o', 'o', 'o', 'o'], ['x', 'o', 'o', 'o', 'o'], ['x', 'x', 'x', 'o', 'o']]))
  end

  def test_ex2
    assert_equal(11, contiguousblock([['x', 'x', 'x', 'x', 'x'], ['x', 'o', 'o', 'o', 'o'], ['x', 'x', 'x', 'x', 'o'], ['x', 'o', 'o', 'o', 'o']]))
  end

  def test_ex3
    assert_equal(7, contiguousblock([['x', 'x', 'x', 'o', 'o'], ['o', 'o', 'o', 'x', 'x'], ['o', 'x', 'x', 'o', 'o'], ['o', 'o', 'o', 'x', 'x']]))
  end

end
