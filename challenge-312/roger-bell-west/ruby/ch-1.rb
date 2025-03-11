#! /usr/bin/ruby

def transfer(a, b)
  ac = a.ord
  bc = b.ord
  [(ac - bc + 26) % 26, (bc - ac + 26) % 26].min
end

def minimumtime(a)
  tot = a.length
  prev = 'a'
  a.chars do |c|
    tot += transfer(prev, c)
    prev = c
  end
  tot
end

require 'test/unit'

class TestMinimumtime < Test::Unit::TestCase

  def test_ex1
    assert_equal(5, minimumtime('abc'))
  end

  def test_ex2
    assert_equal(7, minimumtime('bza'))
  end

  def test_ex3
    assert_equal(34, minimumtime('zjpc'))
  end

end
