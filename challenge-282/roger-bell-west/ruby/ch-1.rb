#! /usr/bin/ruby

require 'test/unit'

class TestGoodinteger < Test::Unit::TestCase

  def test_ex1
    assert_equal(444, goodinteger(12344456))
  end

  def test_ex2
    assert_equal(-1, goodinteger(1233334))
  end

  def test_ex3
    assert_equal(0, goodinteger(10020003))
  end

end

def goodinteger(a)
  winsize = 3
  d = a.to_s.chars
  d.each_cons(winsize).each_with_index do |cc, offset|
    if cc[0] == cc[1] && cc[1] == cc[2]
      if (offset == 0 || d[offset - 1] != cc[0]) && (offset == d.size - winsize || d[offset + winsize] != cc[2])
        return cc.join("").to_i
      end
    end
  end
  -1
end
