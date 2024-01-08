#! /usr/bin/ruby

def shortestdistance(a, c)
  q = []
  i = 0
  while i >= 0 do
    p = a.index(c, i)
    if p then
      q.push([p, 0])
      i = p + 1
    else
      i = -1
    end
  end
  invalid = a.length + 1
  out = Array.new(a.length) {|i| invalid}
  while q.length > 0 do
    i, v = q.shift
    if out[i] == invalid then
      out[i] = v
      if i > 0 then
        q.push([i - 1, v + 1])
      end
      if i < a.length - 1 then
        q.push([i + 1, v + 1])
      end
    end
  end
  return out
end

require 'test/unit'

class TestShortestdistance < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0], shortestdistance('loveleetcode', 'e'))
  end

  def test_ex2
    assert_equal([3, 2, 1, 0], shortestdistance('aaab', 'b'))
  end

end
