#! /usr/bin/ruby

def wordcount(a)
  ct = 0
  a.each do |w|
    ct += case w[0]
          when  'a', 'e', 'i', 'o', 'u'
            1
          else
            case w[-1]
            when  'a', 'e', 'i', 'o', 'u'
              1
            else
              0
            end
          end
  end
  ct
end

require 'test/unit'

class TestWordcount < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, wordcount(['unicode', 'xml', 'raku', 'perl']))
  end

  def test_ex2
    assert_equal(2, wordcount(['the', 'weekly', 'challenge']))
  end

  def test_ex3
    assert_equal(0, wordcount(['perl', 'python', 'postgres']))
  end

end
