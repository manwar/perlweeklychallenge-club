#! /usr/bin/ruby

def chowla(count)
  a=[]
  1.upto(count) do |n|
    a.push(2.upto((n/2).floor).select{|i| n % i == 0}.sum)
  end
  return a
end

require 'test/unit'

class TestChowla < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21],chowla(20))
  end

end
