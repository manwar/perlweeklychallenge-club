#! /usr/bin/ruby

def relativesort(list1, list2)
  c = Hash.new
  c.default = 0
  list1.each do |n|
    c[n] += 1
  end
  out = []
  list2.each do |i|
    out.concat(Array.new(c[i], i))
    c.delete(i)
  end
  d = c.keys.sort
  d.each do |i|
    out.concat(Array.new(c[i], i))
  end
  out
end

require 'test/unit'

class TestRelativesort < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9], relativesort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6]))
  end

  def test_ex2
    assert_equal([1, 3, 3, 3, 2, 2, 4, 4, 6], relativesort([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2]))
  end

  def test_ex3
    assert_equal([1, 1, 1, 0, 0, 3, 2, 4, 5], relativesort([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2]))
  end

end
