#! /usr/bin/ruby

def frequencysort(a)
  ct = Hash.new(0)
  a.each do |x|
    ct[x] += 1
  end
  rct = Hash.new { |h, k| h[k] = [] }
  ct.each do |k, v|
    rct[v].push(k)
  end
  out = []
  rct.keys.sort.each do |k|
    rct[k].sort.reverse.each do |v|
      out += Array.new(k, v)
    end
  end
  return out
end

require 'test/unit'

class TestFrequencysort < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 1, 1, 2, 2, 2], frequencysort([1, 1, 2, 2, 2, 3]))
  end

  def test_ex2
    assert_equal([1, 3, 3, 2, 2], frequencysort([2, 3, 1, 3, 2]))
  end

  def test_ex3
    assert_equal([5, -1, 4, 4, -6, -6, 1, 1, 1], frequencysort([-1, 1, -6, 4, 5, -6, 1, 4, 1]))
  end

end
