#! /usr/bin/ruby

def backspacecompare(a, b)
  sa = Array.new
  [a, b].each do |i|
    oa = Array.new
    i.chars.each do |c|
      if c == '#'
        oa.pop
      else
        oa.push(c)
      end
    end
    sa.push(oa.join(""))
  end
  sa[0] == sa[1]
end

require 'test/unit'

class TestBackspacecompare < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, backspacecompare('ab#c', 'ad#c'))
  end

  def test_ex2
    assert_equal(true, backspacecompare('ab##', 'a#b#'))
  end

  def test_ex3
    assert_equal(false, backspacecompare('a#b', 'c'))
  end

end
