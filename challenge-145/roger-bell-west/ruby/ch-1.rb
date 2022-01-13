#! /usr/bin/ruby

def dotproduct(a,b)
  p=0
  a.each_with_index do |v,i|
    p += v * b[i]
  end
  return p
end

require 'test/unit'

class TestDotproduct < Test::Unit::TestCase

  def test_ex1
    assert_equal(32,dotproduct([1,2,3],[4,5,6]))
  end

end
