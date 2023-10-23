#! /usr/bin/ruby

def samestring(a, b)
  return a.join("") == b.join("")
end

require 'test/unit'

class TestSamestring < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, samestring(['ab', 'c'], ['a', 'bc']))
  end

  def test_ex2
    assert_equal(false, samestring(['ab', 'c'], ['ac', 'b']))
  end

  def test_ex3
    assert_equal(true, samestring(['ab', 'cd', 'e'], ['abcde']))
  end

end
