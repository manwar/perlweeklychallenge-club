#! /usr/bin/ruby

require 'set'

def noconnection(a)
  os = Set.new(a.map {|x| x[0]})
  is = Set.new(a.map {|x| x[1]})
  (is - os).to_a[0]
end

require 'test/unit'

class TestNoconnection < Test::Unit::TestCase

  def test_ex1
    assert_equal('A', noconnection([['B', 'C'], ['D', 'B'], ['C', 'A']]))
  end

  def test_ex2
    assert_equal('Z', noconnection([['A', 'Z']]))
  end

end
