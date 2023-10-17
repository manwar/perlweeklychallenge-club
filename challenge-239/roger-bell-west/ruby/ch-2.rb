#! /usr/bin/ruby

require 'set'

def consistentstrings(a, v)
  vs = Set.new(v.split(''))
  return a.find_all { |s| Set.new(s.split('')).all? {|c| vs.include?(c) } }.length
end

require 'test/unit'

class TestConsistentstrings < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, consistentstrings(['ad', 'bd', 'aaab', 'baa', 'badab'], 'ab'))
  end

  def test_ex2
    assert_equal(3, consistentstrings(['a', 'b', 'c', 'ab', 'ac', 'bc', 'abc'], 'ab'))
  end

  def test_ex3
    assert_equal(4, consistentstrings(['cc', 'acd', 'b', 'ba', 'bac', 'bad', 'ac', 'd'], 'cad'))
  end

end
