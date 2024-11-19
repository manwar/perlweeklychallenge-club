#! /usr/bin/ruby

def compressedunit(count, letter)
  out = ""
  if count > 1
    out += count.to_s
  end
  out += letter
  out
end

def stringcompression(a)
  out = ""
  lastchar = ""
  count = 0
  a.chars.each do |c|
    if count == 0 || c != lastchar
      if count > 0
        out += compressedunit(count, lastchar)
      end
      lastchar = c
      count = 0
    end
    count += 1
  end
  if count > 0
    out += compressedunit(count, lastchar)
  end
  out
end

def stringdecompression(a)
  out = ""
  count = 0
  a.chars.each do |c|
    if c >= '0' && c <= '9'
      count *= 10
      count += c.to_i
    else
      if count == 0
        count = 1
      end
      out += c * count
      count = 0
    end
  end
  out
end

require 'test/unit'

class TestStringcompression < Test::Unit::TestCase

  def test_ex1
    assert_equal('a2bc', stringcompression('abbc'))
  end

  def test_ex2
    assert_equal('3ab3c', stringcompression('aaabccc'))
  end

  def test_ex3
    assert_equal('ab2c', stringcompression('abcc'))
  end

  def test_ex4
    assert_equal('abbc', stringdecompression('a2bc'))
  end

  def test_ex5
    assert_equal('aaabccc', stringdecompression('3ab3c'))
  end

  def test_ex6
    assert_equal('abcc', stringdecompression('ab2c'))
  end

end
