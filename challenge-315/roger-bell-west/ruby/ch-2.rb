#! /usr/bin/ruby

def findthird(s, a, b)
  ss = []
  sa = ""
  s.chars.each do |c|
    cc = c.downcase
    if c >= 'a' && c <= 'z'
      sa += c
    else
      if sa.length > 0
        ss.push(sa)
        sa = ""
      end
    end
  end
  if sa.length > 0
    ss.push(sa)
  end
  out = []
  ss.each_cons(3) do |p|
    if p[0] == a && p[1] == b
      out.push(p[2])
    end
  end
  out
end

require 'test/unit'

class TestFindthird < Test::Unit::TestCase

  def test_ex1
    assert_equal(['language', 'too'], findthird('Perl is a my favourite language but Python is my favourite too.', 'my', 'favourite'))
  end

  def test_ex2
    assert_equal(['doll', 'princess'], findthird('Barbie is a beautiful doll also also a beautiful princess.', 'a', 'beautiful'))
  end

  def test_ex3
    assert_equal(['we', 'rock'], findthird('we will we will rock you rock you.', 'we', 'will'))
  end

end
