#! /usr/bin/ruby

def rearrangespaces(a)
  words = []
  spaces = 0
  ww = ""
  a.chars.each do |c|
    if c == ' '
      spaces += 1
      if ww != ""
        words.push(ww)
        ww = ""
      end
    else
      ww += c
    end
  end
  if ww != ""
    words.push(ww)
  end
  spdiv = 0
  remainder = spaces
  divs = words.size - 1
  if divs > 0
    spdiv, remainder = spaces.divmod(divs)
  end
  out = words.join(" " * spdiv)
  if remainder > 0
    out += " " * remainder
  end
  out
end

require 'test/unit'

class TestRearrangespaces < Test::Unit::TestCase

  def test_ex1
    assert_equal('challenge    ', rearrangespaces('  challenge  '))
  end

  def test_ex2
    assert_equal('coding  is  fun', rearrangespaces('coding  is  fun'))
  end

  def test_ex3
    assert_equal('a b c d ', rearrangespaces('a b c  d'))
  end

  def test_ex4
    assert_equal('team          pwc', rearrangespaces('  team      pwc  '))
  end

  def test_ex5
    assert_equal('the    weekly    challenge ', rearrangespaces('   the  weekly  challenge  '))
  end

end
