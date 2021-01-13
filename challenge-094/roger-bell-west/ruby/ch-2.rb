#! /usr/bin/ruby

def bt2ll(*tree)
  return recurse(tree,0)
end

def recurse(tree,start)
  out=Array.new([tree[start]])
  b=start*2+1
  b.upto(b+1) do |ba|
    if ba <= tree.length && !tree[ba].nil? then
      recurse(tree,ba).each() {|t| out.push(t)}
    end
  end
  return out
end

require 'test/unit'

class TestBt2ll < Test::Unit::TestCase

  def test_ex1
    assert_equal([1,2,4,5,6,7,3],bt2ll(1,2,3,4,5,nil,nil,nil,nil,6,7))
  end

end
