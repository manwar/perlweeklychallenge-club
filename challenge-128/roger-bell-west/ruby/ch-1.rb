#! /usr/bin/ruby

require 'test/unit'

require 'set'

def msm(m)
  y=m.length()
  x=m[0].length()
  mxa=0
  oc=[]
  0.upto(y-1) do |yi|
    0.upto(x-1) do |xi|
      if m[yi][xi]==0 then
        rl=[]
        mrl=x-xi
        yi.upto(y-1) do |yj|
          xi.upto([xi+mrl,x].min-1) do |xj|
            if m[yj][xj] != 0 then
              mrl=[xj-xi,mrl].min
              break
            end
          end
          rl.push(mrl)
        end
        0.upto(rl.length()-1) do |n|
          if rl[n]>0 then
            a=rl[n]*(n+1)
            if a >= mxa then
              mxa=a
              oc=[rl[n],n+1]
            end
          end
        end
      end
    end
  end
  return Array.new(oc[1]) {Array.new(oc[0],0)}
end

class TestMsm < Test::Unit::TestCase

  def test_ex1
    assert_equal([[0,0,0],[0,0,0]],
                 msm([[1,0,0,0,1,0],[1,1,0,0,0,1],[1,0,0,0,0,0]]))
  end

  def test_ex2
    assert_equal([[0,0],[0,0],[0,0]],
                 msm([[0,0,1,1],[0,0,0,1],[0,0,1,0]]))
  end
  
end
