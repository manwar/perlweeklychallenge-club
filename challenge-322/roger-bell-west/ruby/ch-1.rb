#! /usr/bin/ruby

def formatstring(a, n)
  p = a.chars.select{|x| x != '-'}
  r = p.size % n
  if r == 0
    r += n
  end
  o = ""
  p.each_with_index do |c, i|
    if r == i
      o += '-'
      r += n
    end
    o += c
  end
  o
end

require 'test/unit'

class TestFormatstring < Test::Unit::TestCase

  def test_ex1
    assert_equal('ABC-DEF', formatstring('ABC-D-E-F', 3))
  end

  def test_ex2
    assert_equal('A-BC-DE', formatstring('A-BC-D-E', 2))
  end

  def test_ex3
    assert_equal('A-BCDE', formatstring('-A-B-CD-E', 4))
  end

end
