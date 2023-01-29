#! /usr/bin/ruby

require 'test/unit'

require 'set'

def missingnumber(l)
  v = Set.new(l)
  0.upto(l.length) do |i|
    if !v.include?(i) then
      return i
    end
  end
  return 0
end

class TestMissingnumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, missingnumber([0, 1, 3]))
  end

  def test_ex2
    assert_equal(2, missingnumber([0, 1]))
  end

end
