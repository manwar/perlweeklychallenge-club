#! /usr/bin/ruby

def shortestdistance(a0)
  if a0.length % 2 != 0 then
    return []
  end
  a = a0.sort
  out = []
  a.each_slice(2) do |t|
    if t[0] != t[1] then
      return []
    end
    out.push([t[0], t[0]])
  end
  return out
end

require 'test/unit'

class TestShortestdistance < Test::Unit::TestCase

  def test_ex1
    assert_equal([[2, 2], [2, 2], [3, 3]], shortestdistance([3, 2, 3, 2, 2, 2]))
  end

  def test_ex2
    assert_equal([], shortestdistance([1, 2, 3, 4]))
  end

end
