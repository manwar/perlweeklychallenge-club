#! /usr/bin/ruby

def countevendigitsnumber(a)
  t = 0
  a.each do |p|
    even = false
    pt = p
    while pt >= 10
      pt = pt.div(10)
      even = !even
    end
    if even then
      t += 1
    end
  end
  return t                  
end

require 'test/unit'

class TestCountevendigitsnumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, countevendigitsnumber([10, 1, 111, 24, 1000]))
  end

  def test_ex2
    assert_equal(0, countevendigitsnumber([111, 1, 11111]))
  end

  def test_ex3
    assert_equal(1, countevendigitsnumber([2, 8, 1024, 256]))
  end

end
