#! /usr/bin/ruby

def bst(tree)
  limit=[]
  0.upto(tree.length-1) do |i|
    limit[i]=[tree[i],tree[i]]
  end
  ((tree.length-1)/2-1).to_i.downto(0) do |s|
    child=s*2+1
    0.upto(1) do |sb|
      ac=child+sb
      if sb==0 && tree[s]!=0 && limit[ac][1] > tree[s] then
        return 0
      end
      if sb==1 && limit[ac][0]!=0 && limit[ac][0] < tree[s] then
        return 0
      end
    end
    limit[s]=[tree[s],[tree[s],limit[child+1][1]].max]
    if limit[child][0] > 0 then
      limit[s][0]=[tree[s],limit[child][0]].min
    end
  end
  print "#{limit}\n"
  return 1
end

require 'test/unit'

class TestBst < Test::Unit::TestCase

def test_ex1
  assert_equal(1,bst([
                     8,
                     5,      9,
                     4,  6,  0,  0
                   ]))
end

  def test_ex2
    assert_equal(0,bst([
                       5,
                       4,      7,
                       3,  6,  0,  0
                     ]))
  end
  
end
