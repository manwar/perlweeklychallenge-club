#! /usr/bin/ruby

def largestnumber(a)
  ax = a.map{|x| x.to_s}
  ax.sort! do |i, j|
    ij = i + j
    ji = j + i
    ij.to_i <=> ji.to_i
  end
  ax.reverse!
  ax.join("").to_i
end

require 'test/unit'

class TestLargestnumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(320, largestnumber([20, 3]))
  end

  def test_ex2
    assert_equal(9534330, largestnumber([3, 30, 34, 5, 9]))
  end

end
