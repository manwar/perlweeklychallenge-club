#! /usr/bin/ruby

require 'set'

def wordsquares(a)
  l = a[0].length
  words = a.to_set
  queue = []
  a.each do |w|
    queue.push([w])
  end
  while queue.length > 0 do
    p = queue.shift
    if p.length == l
      return p
    end
    (words - p.to_set).each do |ca|
      valid = true
      ca.chars.each_with_index do |c, i|
        if i >= p.length
          break
        end
        if c != p[i][p.length]
          valid = false
          break
        end
      end
      if valid
        pw = p.clone
        pw.push(ca)
        queue.push(pw)
      end
    end
  end
  []
end

require 'test/unit'

class TestWordsquares < Test::Unit::TestCase

  def test_ex1
    assert_equal(['MA', 'AM'], wordsquares(['MA', 'AM', 'MY', 'ME']))
  end

  def test_ex2
    assert_equal(['SUN', 'USE', 'NET'], wordsquares(['SUN', 'USE', 'NET', 'SEE', 'TEN']))
  end

  def test_ex3
    assert_equal(['BOAT', 'OGRE', 'AREA', 'TEAL'], wordsquares(['BOAT', 'TEAL', 'AREA', 'TSAR', 'OGRE']))
  end

  def test_ex4
    assert_equal(['CARD', 'AREA', 'REAR', 'DART'], wordsquares(['CARD', 'AREA', 'REAR', 'DART']))
  end

  def test_ex5
    assert_equal(['HEART', 'EMBER', 'ABUSE', 'RESIN', 'TREND'], wordsquares(['HEART', 'TREND', 'EMBER', 'RESIN', 'ABUSE']))
  end

end
