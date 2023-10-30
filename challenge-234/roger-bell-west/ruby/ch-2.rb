#! /usr/bin/ruby

def unequaltriplets(utl)
  utc = Hash.new(0)
  utl.each do |n|
    utc[n] += 1
  end
  kl = utc.keys
  if kl.length < 3 then
    return 0
  end
  out = 0
  kl.combination(3) do |c|
    out += utc[c[0]] * utc[c[1]] * utc[c[2]]
  end
  return out
end

require 'test/unit'

class TestUnequaltriplets < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, unequaltriplets([4, 4, 2, 4, 3]))
  end

  def test_ex2
    assert_equal(0, unequaltriplets([1, 1, 1, 1, 1]))
  end

  def test_ex3
    assert_equal(28, unequaltriplets([4, 7, 1, 10, 7, 4, 1, 1]))
  end

end
