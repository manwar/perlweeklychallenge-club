#! /usr/bin/ruby

def smallerthancurrent(a)
  b = a.sort()
  m = Hash.new
  b.each_with_index do |v, i|
    if !m.has_key?(v)
      m[v] = i
    end
  end
  a.map{|x| m[x]}
end

require 'test/unit'

class TestSmallerthancurrent < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 1, 0, 3], smallerthancurrent([6, 5, 4, 8]))
  end

  def test_ex2
    assert_equal([0, 0, 0, 0], smallerthancurrent([7, 7, 7, 7]))
  end

  def test_ex3
    assert_equal([4, 3, 2, 1, 0], smallerthancurrent([5, 4, 3, 2, 1]))
  end

  def test_ex4
    assert_equal([1, 2, 4, 0, 3], smallerthancurrent([-1, 0, 3, -2, 1]))
  end

  def test_ex5
    assert_equal([0, 2, 2, 4, 0], smallerthancurrent([0, 1, 1, 2, 0]))
  end

end
