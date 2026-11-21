#! /usr/bin/ruby

require 'set'

def hasrepeateddigits(a)
  cs = Set.new
  a.to_s.chars do |c|
    if cs.include?(c)
      return true
    end
    cs.add(c)
  end
  false
end

def largestinterval(a)
  v = 1.upto(a).select{|x| !hasrepeateddigits(x)}
  v.each_cons(2).map{|d| d[1] - d[0]}.max
end


require 'test/unit'

class TestLargestinterval < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, largestinterval(20))
  end

  def test_ex2
    assert_equal(4, largestinterval(110))
  end

  def test_ex3
    assert_equal(11, largestinterval(500))
  end

  def test_ex4
    assert_equal(105, largestinterval(2026))
  end

  def test_ex5
    assert_equal(105, largestinterval(10000))
  end

end
