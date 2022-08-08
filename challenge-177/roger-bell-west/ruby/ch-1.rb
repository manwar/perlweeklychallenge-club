#! /usr/bin/ruby

require 'test/unit'

def damm(n)
  tab = [
    [0,3,1,7,5,9,8,6,4,2],
    [7,0,9,2,1,5,4,8,6,3],
    [4,2,0,6,8,7,1,3,5,9],
    [1,7,5,0,9,8,3,4,2,6],
    [6,1,2,3,0,4,5,9,7,8],
    [3,6,7,4,2,0,9,5,8,1],
    [5,8,6,9,7,2,0,1,3,4],
    [8,9,4,5,3,6,2,0,1,7],
    [9,4,3,8,6,1,7,2,0,5],
    [2,5,8,1,4,3,6,7,9,0]
  ]
  c = 0
  for digit in n.to_s.chars do
    dd = digit.to_i
    c = tab[c][dd]
  end
  return c
end

def checkdamm(n)
  return damm(n) == 0
end

class TestReversible < Test::Unit::TestCase

  def test_ex1
    assert_equal(true,
                 checkdamm(5724))
  end

  def test_ex2
    assert_equal(false,
                 checkdamm(5727))
  end

end
