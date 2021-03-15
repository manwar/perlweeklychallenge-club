#! /usr/bin/ruby

def ot(pp)
  points=pp
  points.push(pp[0])
  xp=Array.new()
  0.upto(2) do |i|
    xp.append(points[i][0] * (points[i+1][1]-points[i][1])-points[i][1]*(points[i+1][0]-points[i][0]))
  end
  xp.sort!
  if xp[0] <= 0 and xp[2] <= 0 then
    return 1
  end
  if xp[0] >= 0 and xp[2] >= 0 then
    return 1
  end
  return 0
end

require 'test/unit'

class TestPas < Test::Unit::TestCase

  def test_ex1
    assert_equal(0,ot([[0,1],[1,0],[2,2]]))
  end

  def test_ex2
    assert_equal(1,ot([[1,1],[-1,1],[0,-3]]))
  end

  def test_ex3
    assert_equal(1,ot([[0,1],[2,0],[-6,0]]))
  end

end
