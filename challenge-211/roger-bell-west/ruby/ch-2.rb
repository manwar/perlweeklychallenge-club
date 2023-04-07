#! /usr/bin/ruby

require 'test/unit'

def splitsameaverage(a)
  ss = a.sum
  ml = a.length
  mx = ml/2.to_i
  ssa = false
  1.upto(mx) do |n|
    a.combination(n) do |c|
      ca = c.sum
      if (ca.to_f / n.to_f == (ss - ca).to_f / (ml - n).to_f) then
        ssa = true
        break
      end
    end
    if ssa then
      break
    end
  end
  return ssa
end

class TestSplitsameaverage < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, splitsameaverage([1, 2, 3, 4, 5, 6, 7, 8]))
  end

  def test_ex2
    assert_equal(false, splitsameaverage([1, 3]))
  end

  def test_ex3
    assert_equal(true, splitsameaverage([1, 2, 3]))
  end

end
