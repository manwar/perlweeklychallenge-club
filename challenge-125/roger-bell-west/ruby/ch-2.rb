#! /usr/bin/ruby

def btd(tree)
  st=tree.length
  depth=Array.new(st,0)
  diameter=Array.new(st,0)
  (st-1).downto(0) do |i|
    if tree[i] != 0 then
      a=i*2+1
      b=a+1
      if b < st then
        depth[i]=1+[depth[a],depth[b]].max
        diameter[i]=[
          1+depth[a]+depth[b],
          diameter[a],
          diameter[b],
        ].max
      else
        depth[i]=1
        diameter[i]=1
      end
    end
  end
  return diameter[0]
end

require 'test/unit'

class TestBtd < Test::Unit::TestCase

  def test_ex1
    assert_equal(7,btd([1,
                        2,5,
                        3,4,6,7,
                        0,0,0,0,0,0,8,10,
                        0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0
                       ]))
  end
  
end
