#! /usr/bin/ruby

def boomerang(a)
  delta = Array.new
  # coincident points
  0.upto(1) do |ij|
    (ij + 1).upto(2) do |ik|
      if a[ij][0] == a[ik][0] && a[ij][1] == a[ik][1]
        return false
      end
    end
    delta.push([a[ij + 1][0] - a[0][0], a[ij + 1][1] - a[0][1]])
  end
  # all on the same vertical line
  if delta[0][0] == 0 && delta[1][0] == 0
    return false
  end
  # just one vertical line
  if delta[0][0] == 0 || delta[1][0] == 0
    return true
  end
  m = delta[0][1].to_f / delta[0][0].to_f
  c = a[0][1].to_f - a[0][0].to_f * m
  a[2][1].to_f != a[2][0].to_f * m + c
end

require 'test/unit'

class TestBoomerang < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, boomerang([[1, 1], [2, 3], [3, 2]]))
  end

  def test_ex2
    assert_equal(false, boomerang([[1, 1], [2, 2], [3, 3]]))
  end

  def test_ex3
    assert_equal(true, boomerang([[1, 1], [1, 2], [2, 3]]))
  end

  def test_ex4
    assert_equal(false, boomerang([[1, 1], [1, 2], [1, 3]]))
  end

  def test_ex5
    assert_equal(false, boomerang([[1, 1], [2, 1], [3, 1]]))
  end

  def test_ex6
    assert_equal(true, boomerang([[0, 0], [2, 3], [4, 5]]))
  end

end
