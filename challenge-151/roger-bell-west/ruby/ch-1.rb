#! /usr/bin/ruby

require 'test/unit'

def str2tree(st)
  o=[]
  d=0
  p=0
  st.split(' ').each do |e|
    if e == "|" then
      d += 1
      p = 0
      m = (1 << (d+1)) -1
      while o.length < m do
        o.push(0)
      end
    else
      y=0
      if e != "*" then
        y=e.to_i
      end
      i = (1 << d) -1 +p
      o[i] = y 
      p += 1
    end
  end
  return o
end

def mindepth(tree)
  firstleaf=tree.length
  tree.each_with_index do |e,i|
    if e==0 then
      next
    elsif (i+1) << 1 >= tree.length then
      firstleaf = i
      break
    else
      ni=((i+1) << 1)-1
      if tree[ni] == 0 && tree[ni+1] == 0 then
        firstleaf=i
        break
      end
    end
  end
  t=firstleaf+1
  d=0
  while t>0 do
    t >>= 1
    d += 1
  end
  return d
end

class TestMindepth < Test::Unit::TestCase

  def test_ex1
    assert_equal(2,mindepth(str2tree("1 | 2 3 | 4 5")))
  end

  def test_ex2
    assert_equal(3,mindepth(str2tree("1 | 2 3 | 4 *  * 5 | * 6")))
  end

end
