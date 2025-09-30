#! /usr/bin/ruby

def reverseprefix(a, f)
  c = a.split("")
  p = a.index(f)
  if p >= 0
    jr = c.slice(0, p + 1).reverse
    jr.each_with_index do |ch, i|
      c[i] = ch
    end
  end
  c.join("")
end

require 'test/unit'

class TestReverseprefix < Test::Unit::TestCase

  def test_ex1
    assert_equal('gorpramming', reverseprefix('programming', 'g'))
  end

  def test_ex2
    assert_equal('hello', reverseprefix('hello', 'h'))
  end

  def test_ex3
    assert_equal('hgfedcbaij', reverseprefix('abcdefghij', 'h'))
  end

  def test_ex4
    assert_equal('srevere', reverseprefix('reverse', 's'))
  end

  def test_ex5
    assert_equal('repl', reverseprefix('perl', 'r'))
  end

end
