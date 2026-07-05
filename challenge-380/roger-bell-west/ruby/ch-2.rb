#! /usr/bin/ruby

def reversedegree(a)
  t = 0
  z0 = 'z'.ord + 1
  a.chars.each_with_index do |c, i|
    t += (z0 - c.ord) * (1 + i)
  end
  t
end

require 'test/unit'

class TestReversedegree < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, reversedegree('z'))
  end

  def test_ex2
    assert_equal(26, reversedegree('a'))
  end

  def test_ex3
    assert_equal(147, reversedegree('bbc'))
  end

  def test_ex4
    assert_equal(560, reversedegree('racecar'))
  end

  def test_ex5
    assert_equal(14, reversedegree('zyx'))
  end

end
