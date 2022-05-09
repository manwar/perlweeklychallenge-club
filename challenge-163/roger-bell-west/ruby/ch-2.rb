#! /usr/bin/ruby

require 'test/unit'

def summation(ls0)
  ls = ls0
  while ls.length > 1 do
    lv = []
    1.upto(ls.length - 1).each do |i|
      lv.push((1..i).inject(0) {|sum, n| sum + ls[n]})
    end
    ls = lv
  end
  return ls[0]
end

class TestSummation < Test::Unit::TestCase

  def test_ex1
    assert_equal(42,
                 summation([1,2,3,4,5]))
  end

  def test_ex2
    assert_equal(70,
                 summation([1,3,5,7,9]))
  end

end
