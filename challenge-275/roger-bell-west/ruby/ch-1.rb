#! /usr/bin/ruby

require 'set'

def brokenkeys(a, k)
  out = 0
  failset = Set.new(k.map{ |c| c.downcase })
  a.split(" ").each do |word|
    wordset = Set.new(word.downcase.split(""))
    if (wordset & failset).size == 0
      out += 1
    end
  end
  out
end

require 'test/unit'

class TestBrokenkeys < Test::Unit::TestCase

  def test_ex1
    assert_equal(0, brokenkeys('Perl Weekly Challenge', ['l', 'a']))
  end

  def test_ex2
    assert_equal(1, brokenkeys('Perl and Raku', ['a']))
  end

  def test_ex3
    assert_equal(2, brokenkeys('Well done Team PWC', ['l', 'o']))
  end

end
