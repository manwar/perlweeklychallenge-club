#! /usr/bin/ruby

def oddcharacter(s, t)
  ss = Hash.new(0)
  s.chars.each do |c|
    ss[c] += 1
  end
  t.chars.each do |c|
    if ss.has_key?(c) and ss[c] > 0 then
      ss[c] -= 1
    else
      return c
    end
  end
  return "@"
end

require 'test/unit'

class TestOddcharacter < Test::Unit::TestCase

  def test_ex1
    assert_equal('e', oddcharacter('Perl', 'Preel'))
  end

  def test_ex2
    assert_equal('a', oddcharacter('Weekly', 'Weeakly'))
  end

  def test_ex3
    assert_equal('y', oddcharacter('Box', 'Boxy'))
  end

end
