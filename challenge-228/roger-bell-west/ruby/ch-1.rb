#! /usr/bin/ruby

def uniquesum(a)
  c = Hash.new(0)
  a.each do |n|
    c[n] += 1
  end
  return c.keys.find_all {|i| c[i] == 1}.inject(0) {|a, b| a + b}
end

require 'test/unit'

class TestUniquesum < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, uniquesum([2, 1, 3, 2]))
  end

  def test_ex2
    assert_equal(0, uniquesum([1, 1, 1, 1]))
  end

  def test_ex3
    assert_equal(10, uniquesum([2, 1, 3, 4]))
  end

end
