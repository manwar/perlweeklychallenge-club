#! /usr/bin/ruby

def subsetequilibrium(a)
  out = []
  b = a.each_with_index.map{|x, i| x - i - 1}.to_a
  ix = (0 .. b.size - 1).to_a
  1.upto(b.size - 1) do |n|
    ix.combination(n).each do |iy|
      bp = iy.map{|i| b[i]}.sum
      if bp == 0
        ap = iy.map{|i| a[i]}
        out.push(ap)
      end
    end
  end
  out.sort()
end

require 'test/unit'

class TestSubsetequilibrium < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1, 4], [2, 1], [2, 3], [4, 3]], subsetequilibrium([2, 1, 4, 3]))
  end

  def test_ex2
    assert_equal([[3], [3, 0], [3, 0, 3]], subsetequilibrium([3, 0, 3, 0]))
  end

  def test_ex3
    assert_equal([[5, 1, 1]], subsetequilibrium([5, 1, 1, 1]))
  end

  def test_ex4
    assert_equal([[3, -1, 4], [3, 2]], subsetequilibrium([3, -1, 4, 2]))
  end

  def test_ex5
    assert_equal([], subsetequilibrium([10, 20, 30, 40]))
  end

end
