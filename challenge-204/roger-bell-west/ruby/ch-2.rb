#! /usr/bin/ruby

require 'test/unit'

def reshapematrix(m, r, c)
  mv = m.flatten()
  if r * c != mv.length then
    return [[0]]
  end
  out = []
  0.upto(r - 1) do |i|
    out.push(mv[i * c .. (i + 1) * c - 1])
  end
  return out
end

class TestReshapematrix < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1, 2, 3, 4]], reshapematrix([[1, 2], [3, 4]], 1, 4))
  end

  def test_ex2
    assert_equal([[1, 2], [3, 4], [5, 6]], reshapematrix([[1, 2, 3], [4, 5, 6]], 3, 2))
  end

  def test_ex3
    assert_equal([[0]], reshapematrix([[1, 2]], 3, 2))
  end

end
