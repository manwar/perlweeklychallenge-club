#! /usr/bin/ruby

require 'test/unit'

def is_wigglesorted(l)
  0.upto(l.length-2) do |i|
    if i % 2 == 0 then
      if l[i] >= l[i+1] then
        return false
      end
    else
      if l[i] <= l[i+1] then
        return false
      end
    end
  end
  return true
end

def wigglesort(l)
  s = l.sort
  le = s.length
  p = le.div(2)
  a = s[0 .. p-1]
  b = s[p .. -1]
  i = 0
  o = []
  if le % 2 == 1 then
    o.push(s[p])
    b = s[p+1 .. -1]
    i = 1
  end
  i.upto(le-1) do |j|
    if j % 2 == 0 then
      o.push(a.pop)
    else
      o.push(b.pop)
    end
  end
  return o
end

class TestRangeList < Test::Unit::TestCase
  def test_ex1
    assert_equal(false, is_wigglesorted([1,5,1,1,6,4]))
  end
  
  def test_ex2
    assert_equal(true, is_wigglesorted([1,6,1,5,1,4]))
  end
  
  def test_ex3
    assert_equal(false, is_wigglesorted([1,3,2,2,3,1]))
  end
  
  def test_ex4
    assert_equal(true, is_wigglesorted([2,3,1,3,1,2]))
  end
  
  def test_ex5
    assert_equal(false, is_wigglesorted([1,3,2,2,3,1]))
  end
  
  def test_ex6
    assert_equal(true, is_wigglesorted(wigglesort([1,5,1,1,6,4])))
  end
  
  def test_ex7
    assert_equal(true, is_wigglesorted(wigglesort([1,3,2,2,3,1])))
  end
  
  def test_ex8
    assert_equal(true, is_wigglesorted(wigglesort([1,3,2,2,2,3,1])))
  end
  
end
