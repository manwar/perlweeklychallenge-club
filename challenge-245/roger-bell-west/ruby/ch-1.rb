#! /usr/bin/ruby

def sortlanguage(langs, popularities)
  ix = (0...langs.length).to_a
  ix = ix.sort_by {|n| popularities[n]}
  return ix.collect {|n| langs[n]}
end

require 'test/unit'

class TestSortlanguage < Test::Unit::TestCase

  def test_ex1
    assert_equal(['c', 'perl', 'python'], sortlanguage(['perl', 'c', 'python'], [2, 1, 3]))
  end

  def test_ex2
    assert_equal(['c++', 'java', 'haskell'], sortlanguage(['c++', 'haskell', 'java'], [1, 3, 2]))
  end

end
