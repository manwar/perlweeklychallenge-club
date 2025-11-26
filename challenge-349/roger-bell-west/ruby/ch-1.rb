#! /usr/bin/ruby

def powerstring(a)
  mx = 0
  prev = 'A'
  cur = 0
  a.chars.each do |c|
    if cur > 0 && c == prev
      cur += 1
    else
      cur = 1
      prev = c
    end
    mx = [mx, cur].max
  end
  mx
end

require 'test/unit'

class TestPowerstring < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, powerstring('textbook'))
  end

  def test_ex2
    assert_equal(5, powerstring('aaaaa'))
  end

  def test_ex3
    assert_equal(3, powerstring('hoorayyy'))
  end

  def test_ex4
    assert_equal(1, powerstring('x'))
  end

  def test_ex5
    assert_equal(4, powerstring('aabcccddeeffffghijjk'))
  end

end
