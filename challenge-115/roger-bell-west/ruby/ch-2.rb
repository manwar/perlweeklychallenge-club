#! /usr/bin/ruby
# coding: utf-8

require 'test/unit'

def lm(*n)
  o=n.sort()
  i=o.find_index {|x| x % 2 == 0}
  if i.nil? then
    return 0
  end
  ox=[o[i]]
  if i>0 then
    ox.push(o[0..i-1])
  end
  if i+1<o.length() then
    ox.push(o[i+1..-1])
  end
  ox.flatten!
  return ox.reverse().join('').to_i
end


class TestLm < Test::Unit::TestCase

  def test_ex1
    assert_equal(6210,lm(1,0,2,6))
  end
  
  def test_ex2
    assert_equal(8412,lm(1,4,2,8))
  end
  
  def test_ex3
    assert_equal(7614,lm(4,1,7,6))
  end
  
  def test_ex4
    assert_equal(0,lm(1,3,5,7))
  end
  
end
