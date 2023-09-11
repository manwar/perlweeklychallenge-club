#! /usr/bin/ruby

require 'set'

def similarwords(a)
  ct = Hash.new
  ct.default = 0
  ac = 'a'.ord
  a.each do |w|
    hs = Set.new(w.split(''))
    mask = 0
    hs.each do |c|
      mask |= 1 << (c.ord - ac)
    end
    ct[mask] += 1
  end
  pairs = 0
  ct.values.each do |cv|
    if cv > 1 then
      pairs += cv * (cv - 1) / 2
    end
  end
  return pairs
end

require 'test/unit'

class TestSimilarwords < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, similarwords(['aba', 'aabb', 'abcd', 'bac', 'aabc']))
  end

  def test_ex2
    assert_equal(3, similarwords(['aabb', 'ab', 'ba']))
  end

  def test_ex3
    assert_equal(0, similarwords(['nba', 'cba', 'dba']))
  end

end
