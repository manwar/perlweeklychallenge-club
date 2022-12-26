#! /usr/bin/ruby

require 'test/unit'

def movezero(l)
  o = l.find_all{|i| i != 0}
  return o.concat(Array.new(l.length-o.length, 0))
end

class TestMovezero < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 3, 5, 0, 0, 0], movezero([1, 0, 3, 0, 0, 5]))
  end

  def test_ex2
    assert_equal([1, 6, 4], movezero([1, 6, 4]))
  end

  def test_ex3
    assert_equal([1, 2, 0, 0, 0], movezero([0, 1, 0, 2, 0]))
  end
end
