#! /usr/bin/ruby

def maximumfrequency(a)
  c = Hash.new
  c.default = 0
  a.each do |w|
    c[w] += 1
  end
  mx = c.values.max
  return c.values.find_all{|v| v == mx}.length * mx
end

require 'test/unit'

class TestMaximumfrequency < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, maximumfrequency([1, 2, 2, 4, 1, 5]))
  end

  def test_ex2
    assert_equal(5, maximumfrequency([1, 2, 3, 4, 5]))
  end

end
