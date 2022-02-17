#! /usr/bin/ruby

require 'test/unit'

def tsp(tree)
  mp=0
  tree.each do |r|
    mp += r.min
  end
  return mp
end

class TestTsp < Test::Unit::TestCase

  def test_ex1
    assert_equal(8,tsp([[1],[5,3],[2,3,4],[7,1,0,2],[6,4,5,2,8]]))
  end

  def test_ex2
    assert_equal(9,tsp([[5],[2,3],[4,1,4],[0,1,2,3],[7,2,4,1,9]]))
  end

end
