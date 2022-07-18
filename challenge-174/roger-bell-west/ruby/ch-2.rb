#! /usr/bin/ruby

require 'test/unit'

def permutation2rank(perm)
  n = 0
  pp = perm.sort
  oi = []
  l = 1
  2.upto(perm.length) do |index|
    oi.push(l)
    l *= index
  end
  oi = oi.reverse
  0.upto(perm.length-2) do |index|
    base = {}
    pp.each_with_index do |e, i|
      base[e] = i
    end
    n += oi[index] * base[perm[index]]
    base.delete(perm[index])
    pp = base.keys.sort
  end
  return n
end

def rank2permutation(perm, rank0)
  rank = rank0
  pp = perm.sort
  o = []
  oi = []
  l = 1
  2.upto(perm.length) do |index|
    oi.push(l)
    l *= index
  end
  oi = oi.reverse
  0.upto(perm.length-2) do |index|
    ix,rank = rank.divmod(oi[index])
    o.push(pp[ix])
    pp = pp.find_all {|i| i != pp[ix]}
  end
  o.push(pp[0])
  return o
end

class TestPermRank < Test::Unit::TestCase

  def test_ex1
    assert_equal(2,
                 permutation2rank([1,0,2]))
  end

  def test_ex2
    assert_equal([0,2,1],
                 rank2permutation([0,1,2],1))
  end

  def test_ex3
    assert_equal(13,
                 permutation2rank([2,0,3,1]))
  end

  def test_ex4
    assert_equal([1,0,3,2],
                 rank2permutation([1,3,2,0],7))
  end

end
