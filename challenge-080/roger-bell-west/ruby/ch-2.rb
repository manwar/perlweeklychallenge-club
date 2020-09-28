#! /usr/bin/ruby

def cc(list)
  n=(0...list.length).sort_by {|x| list[x]}
  k=Array.new(list.length) {0}
  for i in n
    nr=[1]
    if i > 0 && list[i-1] < list[i]
      nr.push(k[i-1]+1)
    end
    if i < list.length-1 && list[i+1] < list[i]
      nr.push(k[i+1]+1)
    end
    k[i]=nr.max
  end
  return k.sum
end

require 'test/unit'

class TestCc < Test::Unit::TestCase

  def test_1
    assert_equal(4,cc([1,2,2]))
  end

  def test_2
    assert_equal(7,cc([1,4,3,2]))
  end

end
