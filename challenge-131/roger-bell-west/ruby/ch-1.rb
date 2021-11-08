#! /usr/bin/ruby

def csa(list)
  o=[[list[0]]]
  1.upto(list.length-1) do |ni|
    unless o[-1][-1]+1 == list[ni] then
      o.push([])
    end
    o[-1].push(list[ni])
  end
  return o
end

require 'test/unit'

class TestCsa < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1,2,3],[6,7,8,9]],csa([1,2,3,6,7,8,9]))
  end

  def test_ex2
    assert_equal([[11,12],[14],[17,18,19]],csa([11,12,14,17,18,19]))
  end

  def test_ex3
    assert_equal([[2],[4],[6],[8]],csa([2,4,6,8]))
  end

  def test_ex4
    assert_equal([[1,2,3,4,5]],csa([1,2,3,4,5]))
  end

end
