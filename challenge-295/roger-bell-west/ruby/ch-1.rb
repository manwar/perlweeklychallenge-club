#! /usr/bin/ruby

def wordbreak(a, words)
  queue = [a]
  while queue.length > 0
    remnant = queue.shift
    if remnant.length == 0
      return true
    end
    words.each do |candidate|
      if remnant.index(candidate) == 0
        queue.push(remnant.slice(candidate.length .. -1))
      end
    end
  end
  false
end

require 'test/unit'

class TestWordbreak < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, wordbreak('weeklychallenge', ['challenge', 'weekly']))
  end

  def test_ex2
    assert_equal(true, wordbreak('perlrakuperl', ['raku', 'perl']))
  end

  def test_ex3
    assert_equal(false, wordbreak('sonsanddaughters', ['sons', 'sand', 'daughters']))
  end

end
