#! /usr/bin/ruby

def is_vowel(c)
  if c.downcase =~ /[aeiou]/ then
    return true
  else
    return false
  end
end

def reversevowels(a)
  p = a.split('')
  q = p.find_all { |c| is_vowel(c) }
  qi = q.length
  o = []
  p.each do |c|
    if is_vowel(c)
      qi -= 1
      nc = q[qi]
      if c == c.upcase then
        nc = nc.upcase
      else
        nc = nc.downcase
      end
      o.push(nc)
    else
      o.push(c)
    end
  end
  return o.join("")
end

require 'test/unit'

class TestReversevowels < Test::Unit::TestCase

  def test_ex1
    assert_equal('Ruka', reversevowels('Raku'))
  end

  def test_ex2
    assert_equal('Perl', reversevowels('Perl'))
  end

  def test_ex3
    assert_equal('Jaliu', reversevowels('Julia'))
  end

  def test_ex4
    assert_equal('Auiu', reversevowels('Uiua'))
  end

end
