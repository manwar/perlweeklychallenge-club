#! /usr/bin/ruby

def popcount(x0)
  x = x0
  c = 0
  while x > 0 do
    x &= x - 1
    c += 1
  end
  return c
end

def hammingdistance(a)
  t = 0
  0.upto(a.size - 2) do |i|
    i.upto(a.size - 1) do |j|
      t += popcount(a[i] ^ a[j])
    end
  end
  t
end

require 'test/unit'

class TestHammingdistance < Test::Unit::TestCase

  def test_ex1
    assert_equal(6, hammingdistance([4, 14, 2]))
  end

  def test_ex2
    assert_equal(4, hammingdistance([4, 14, 4]))
  end

end
