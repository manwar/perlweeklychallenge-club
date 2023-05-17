#! /usr/bin/ruby

def maxnumber(lst)
  po = lst.collect {|i| i.to_s}
  pl = po.collect {|i| i.length}.max
  pm = []
  po.each do |so|
    sm = so
    while sm.length < pl do
      sm += sm[-1]
    end
    pm.push(sm)
  end
  pi = 0.upto(pm.length - 1).to_a
  pi.sort_by! { |i| pm[i] }
  pi = pi.reverse
  out = ""
  pi.each do |st|
    out += po[st]
  end
  return out.to_i
end

require 'test/unit'

class TestMaxnumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(231, maxnumber([1, 23]))
  end

  def test_ex2
    assert_equal(3210, maxnumber([10, 3, 2]))
  end

  def test_ex3
    assert_equal(431210, maxnumber([31, 2, 4, 10]))
  end

  def test_ex4
    assert_equal(542111, maxnumber([5, 11, 4, 1, 2]))
  end

  def test_ex5
    assert_equal(110, maxnumber([1, 10]))
  end

end
