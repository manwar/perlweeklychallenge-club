#! /usr/bin/ruby

def uniquenumber(a)
  c = Hash.new
  c.default = 0
  a.each do |n|
    c[n] += 1
  end
  c.select{|k, v| v == 1}.map{|k, v| k}[0]
end

require 'test/unit'

class TestUniquenumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, uniquenumber([3, 3, 1]))
  end

  def test_ex2
    assert_equal(3, uniquenumber([3, 2, 4, 2, 4]))
  end

  def test_ex3
    assert_equal(1, uniquenumber([1]))
  end

  def test_ex4
    assert_equal(3, uniquenumber([4, 3, 1, 1, 1, 4]))
  end

end
