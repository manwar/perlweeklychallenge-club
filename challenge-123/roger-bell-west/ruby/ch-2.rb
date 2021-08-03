#! /usr/bin/ruby

def sp(m)
  [[0,1,2,3,0],[0,1,3,2,0],[0,2,1,3,0]].each do |ordering|
    w=0.upto(4).map{|i| m[ordering[i%4]]}
    ds=[]
    0.upto(3) do |pp|
      ds.push((w[pp+1][0]-w[pp][0])**2+(w[pp+1][1]-w[pp][1])**2)
    end
    t=ds.minmax
    if t[0] != t[1] then
      next
    end
    rad2deg=90/Math.acos(0)
    angles=[]
    0.upto(3) do |pp|
      delta=0.upto(1).map{|i| w[pp+1][i]-w[pp][i]}
      if delta[0]==0 then
        if delta[1]==0 then
          return 0
        end
        angle=delta[1]>0 ? 90 : -90
      else
        angle=Math.atan2(delta[1],delta[0])*rad2deg
      end
      angles.push(angle)
    end
    angles.push(angles[0])
    good=1
    deltas=0.upto(3).map{|i| (angles[i+1]-angles[i]+360)%360}
    if deltas[0] != 90 and deltas[0] != 270 then
      next
    else
      1.upto(3) do |di|
        if deltas[di] != deltas[0] then
          good=0
          break
        end
      end
    end
    return good
  end
  return 0
end

require 'test/unit'

class TestSp < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,sp([
                        [10,20],
                        [20,20],
                        [20,10],
                        [10,10]
                      ]))
  end

  def test_ex2
    assert_equal(0,sp([
                        [12,24],
                        [16,10],
                        [20,12],
                        [18,16]
                      ]))
  end

  def test_ex3
    assert_equal(1,sp([
                        [10,10],
                        [20,0],
                        [30,10],
                        [20,20]
                      ]))
  end

  def test_ex4
    assert_equal(0,sp([
                        [0,0],
                        [3,4],
                        [8,4],
                        [5,0]
                      ]))
  end
  
end
