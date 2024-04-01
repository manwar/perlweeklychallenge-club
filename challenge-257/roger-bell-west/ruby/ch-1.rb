#! /usr/bin/ruby

def smallerthancurrent(a)
  s = a.sort
  l = Hash.new
  s.each_with_index do |n, i|
    if !l.has_key?(n) then
      l[n] = i
    end
  end
  return a.collect { |n| l[n] }
end

require 'test/unit'

class TestSmallerthancurrent < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 1, 0, 3], smallerthancurrent([5, 2, 1, 6]))
  end

  def test_ex2
    assert_equal([1, 2, 0, 3], smallerthancurrent([1, 2, 0, 3]))
  end

  def test_ex3
    assert_equal([0, 1], smallerthancurrent([0, 1]))
  end

  def test_ex4
    assert_equal([2, 1, 2, 0], smallerthancurrent([9, 4, 9, 2]))
  end

end
