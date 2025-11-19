#! /usr/bin/ruby

def stringalike(a)
  if a.size % 2 == 1
    return false
  end
  vt = 0
  mode = 1
  av = false
  a.downcase.chars.each_with_index do |c, i|
    if i * 2 == a.size
      mode = -1
    end
    if c =~ /[aeiou]/
      vt += mode
      av = true
    end
  end
  av && (vt == 0)
end

require 'test/unit'

class TestStringalike < Test::Unit::TestCase

  def test_ex1
    assert_equal(false, stringalike('textbook'))
  end

  def test_ex2
    assert_equal(true, stringalike('book'))
  end

  def test_ex3
    assert_equal(true, stringalike('AbCdEfGh'))
  end

  def test_ex4
    assert_equal(false, stringalike('rhythmmyth'))
  end

  def test_ex5
    assert_equal(false, stringalike('UmpireeAudio'))
  end

end
