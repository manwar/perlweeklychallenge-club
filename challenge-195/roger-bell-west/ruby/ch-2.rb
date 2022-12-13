#! /usr/bin/ruby

require 'test/unit'

def mostfrequenteven(l)
  f = Hash.new(0)
  l.each do |n|
    if n % 2 == 0 then
      f[n] += 1
    end
  end
  if f.length > 0 then
    m = f.values.max
    l = f.keys.find_all { |x| f[x] == m}.sort
    return l[0]
  else
    return -1
  end
end

class TestMostFrequentEven < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, mostfrequenteven([1, 1, 2, 6, 2]))
  end

  def test_ex2
    assert_equal(-1, mostfrequenteven([1, 3, 5, 7]))
  end

  def test_ex3
    assert_equal(4, mostfrequenteven([6, 4, 4, 6, 1]))
  end
end
