#! /usr/bin/ruby

def echochamber(a)
  out = ""
  a.split("").each_with_index do |c, i|
    out += c * (i + 1)
  end
  out
end

require 'test/unit'

class TestEchochamber < Test::Unit::TestCase

  def test_ex1
    assert_equal('abbcccaaaa', echochamber('abca'))
  end

  def test_ex2
    assert_equal('xyyzzz', echochamber('xyz'))
  end

  def test_ex3
    assert_equal('coodddeeee', echochamber('code'))
  end

  def test_ex4
    assert_equal('heelllllllooooo', echochamber('hello'))
  end

  def test_ex5
    assert_equal('a', echochamber('a'))
  end

end
