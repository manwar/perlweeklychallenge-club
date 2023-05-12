#! /usr/bin/ruby

require 'set'

def word2set(word)
  return Set.new(word.downcase.chars.find_all {|i| i >= 'a' && i <= 'z'})
end

def registrationnumber(words, reg)
  out = []
  words.each do |w|
    ss = word2set(reg)
    word2set(w).each do |char|
      if ss.include?(char) then
        ss.delete(char)
        if ss.length == 0 then
          out.push(w)
          break
        end
      end
    end
  end
  return out
end

require 'test/unit'

class TestRegistrationnumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(['abcd'], registrationnumber(['abc', 'abcd', 'bcd'], 'AB1 2CD'))
  end

  def test_ex2
    assert_equal(['job', 'bjorg'], registrationnumber(['job', 'james', 'bjorg'], '007 JB'))
  end

  def test_ex3
    assert_equal(['crack', 'rac'], registrationnumber(['crack', 'road', 'rac'], 'C7 RA2'))
  end

end
