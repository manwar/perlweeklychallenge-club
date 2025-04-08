#! /usr/bin/ruby

def circular(a)
  a.each_cons(2) do |p|
    if p[0][-1] != p[1][0]
        return false
    end
  end
  true
end

require 'test/unit'

class TestCircular < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, circular(['perl', 'loves', 'scala']))
  end

  def test_ex2
    assert_equal(false, circular(['love', 'the', 'programming']))
  end

  def test_ex3
    assert_equal(true, circular(['java', 'awk', 'kotlin', 'node.js']))
  end

end
