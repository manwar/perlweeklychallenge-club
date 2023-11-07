#! /usr/bin/ruby

require 'set'

def halfmissing(a, bh)
  return a.find_all {|n| !bh.include?(n)}.uniq
end

def missingmembers(a, b)
  ah = Set.new(a)
  bh = Set.new(b)
  return [
    halfmissing(a, bh),
    halfmissing(b, ah)
  ]
end

require 'test/unit'

class TestMissingmembers < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1, 3], [4, 6]], missingmembers([1, 2, 3], [2, 4, 6]))
  end

  def test_ex2
    assert_equal([[3], []], missingmembers([1, 2, 3, 3], [1, 1, 2, 2]))
  end

end
