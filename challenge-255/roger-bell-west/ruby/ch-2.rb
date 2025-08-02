#! /usr/bin/ruby

def mostfrequentword(para, banned)
  words = Hash.new(0)
  para.split(/[^A-Za-z]+/).find_all{|v| v.length > 0}.each do |c|
    words[c] += 1
  end
  words.delete(banned)
  m = words.values.max
  v = words.keys.find_all{|w| words[w] == m}
  return v[0]
end

require 'test/unit'

class TestMostfrequentword < Test::Unit::TestCase

  def test_ex1
    assert_equal('ball', mostfrequentword('Joe hit a ball, the hit ball flew far after it was hit.', 'hit'))
  end

  def test_ex2
    assert_equal('Perl', mostfrequentword('Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.', 'the'))
  end

end
