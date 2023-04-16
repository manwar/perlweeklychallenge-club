#! /usr/bin/ruby

require 'test/unit'

def jumpingletters(word, jump)
  s = ""
  word.split(//).each_with_index do |c, i|
    d = c.ord + jump[i] % 26
    if (c <= "Z" && d > 90) || d > 122 then
      d -= 26
    end
    s += d.chr()
  end
  return s
end

class TestJumpingletters < Test::Unit::TestCase

  def test_ex1
    assert_equal('Raku', jumpingletters('Perl', [2, 22, 19, 9]))
  end

  def test_ex2
    assert_equal('Perl', jumpingletters('Raku', [24, 4, 7, 17]))
  end

end
