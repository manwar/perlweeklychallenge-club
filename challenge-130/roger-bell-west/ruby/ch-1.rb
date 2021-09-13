#! /usr/bin/ruby

require 'set'

def on(list)
  k=Set.new
  list.each do |n|
    if k.include?(n) then
      k.delete(n)
    else
      k.add(n)
    end
  end
  return k.to_a[0]
end

require 'test/unit'

class TestRd < Test::Unit::TestCase

  def test_ex1
    assert_equal(5,on([2,5,4,4,5,5,2]))
  end

  def test_ex2
    assert_equal(4,on([1,2,3,4,3,2,1,4,4]))
  end
  
end
