#! /usr/bin/ruby

def mergestrings(a, b)
  aa = a.chars.to_a
  bb = b.chars.to_a
  out = ""
  0.upto([a.length, b.length].max - 1) do |i|
    if i < a.length then
      out += aa[i]
    end
    if i < b.length then
      out += bb[i]
    end
  end
  return out
end

require 'test/unit'

class TestMergestrings < Test::Unit::TestCase

  def test_ex1
    assert_equal('a1b2c3d4', mergestrings('abcd', '1234'))
  end

  def test_ex2
    assert_equal('a1b2c345', mergestrings('abc', '12345'))
  end

  def test_ex3
    assert_equal('a1b2c3de', mergestrings('abcde', '123'))
  end

end
