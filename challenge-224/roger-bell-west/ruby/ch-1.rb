#! /usr/bin/ruby

def word2map(word)
  m = Hash.new
  word.downcase.chars.find_all {|i| i >= 'a' && i <= 'z'}.each do |c|
    if m.has_key?(c) then
      m[c] += 1
    else
      m[c] = 1
    end
  end
  return m
end

def specialnotes(chars, word)
  cm = word2map(chars)
  f = word2map(word)
  valid = true
  f.keys.each do |c|
    if !cm.has_key?(c) or f[c] > cm[c] then
      valid = false
      break
    end
  end
  return valid
end

require 'test/unit'

class TestSpecialnotes < Test::Unit::TestCase

  def test_ex1
    assert_equal(false, specialnotes('abc', 'xyz'))
  end

  def test_ex2
    assert_equal(true, specialnotes('scriptinglanguage', 'perl'))
  end

  def test_ex3
    assert_equal(true, specialnotes('aabbcc', 'abc'))
  end

end
