#! /usr/bin/ruby

require 'test/unit'

def oddoneout(a)
  ct = 0
  a.each do |s|
    p = s.chars.to_a
    p.sort!
    if p.join != s then
      ct += 1
    end
  end
  return ct
end

class TestOddoneout < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, oddoneout(['abc', 'xyz', 'tsu']))
  end

  def test_ex2
    assert_equal(3, oddoneout(['rat', 'cab', 'dad']))
  end

  def test_ex3
    assert_equal(0, oddoneout(['x', 'y', 'z']))
  end

end
