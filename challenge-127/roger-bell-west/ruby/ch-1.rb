#! /usr/bin/ruby

require 'test/unit'

require 'set'

def ds(a,b)
  sa=Set.new(a)
  sb=Set.new(b)
  inter=sa & sb
  if inter.length()==0 then
    return 1
  else
    return 0
  end
end

class TestDs < Test::Unit::TestCase

  def test_ex1
    assert_equal(0,ds([1,2,5,3,4],[4,6,7,8,9]))
  end

  def test_ex2
    assert_equal(1,ds([1,3,5,7,9],[0,2,4,6,8]))
  end
  
end
