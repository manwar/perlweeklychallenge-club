#! /usr/bin/ruby

require 'test/unit'

def sumbitwise(ls)
  return ls.combination(2).inject(0) {|sum, n| sum + (n[0] & n[1])}
end

class TestSumbitwise < Test::Unit::TestCase

  def test_ex1
    assert_equal(3,
                 sumbitwise([1,2,3]))
  end

  def test_ex2
    assert_equal(2,
                 sumbitwise([2,3,4]))
  end

end
