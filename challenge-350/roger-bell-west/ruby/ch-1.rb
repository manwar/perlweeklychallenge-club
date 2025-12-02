#! /usr/bin/ruby

def counterify(a)
  cc = Hash.new
  cc.default = 0
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def goodsubstrings(a)
  p = 0
  a.chars.each_cons(3) do |s|
    c = counterify(s)
    if c.values.max == 1
      p += 1
    end
  end
  p
end

require 'test/unit'

class TestGoodsubstrings < Test::Unit::TestCase

  def test_ex1
    assert_equal(5, goodsubstrings('abcaefg'))
  end

  def test_ex2
    assert_equal(3, goodsubstrings('xyzzabc'))
  end

  def test_ex3
    assert_equal(1, goodsubstrings('aababc'))
  end

  def test_ex4
    assert_equal(4, goodsubstrings('qwerty'))
  end

  def test_ex5
    assert_equal(0, goodsubstrings('zzzaaa'))
  end

end
