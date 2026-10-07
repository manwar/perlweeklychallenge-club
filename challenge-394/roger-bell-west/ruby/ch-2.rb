#! /usr/bin/ruby

def common_substring(a0)
  a = a0.sort_by { |x| x.length }
  results = []
  (a[0].length - 1).downto(1) do |l|
    0.upto(a[0].length - l) do |offset|
      m = true
      sample = a[0][offset..offset + l - 1]
      1.upto(a.length - 1) do |axi|
        if a[axi].index(sample).nil?
          m = false
          break
        end
      end
      if m
        results.push(sample)
      end
    end
    # for _longest_ common substring...
    # if results.length > 0
    #  break
    # end
  end
  results
end

def is_avc(a)
  valid = true
  laststate = false
  a.chars.each_with_index do |c, i|
    thisstate = false
    case c
    when 'a', 'e', 'i', 'o', 'u'
      thisstate = true
    end
    if i > 0 && thisstate == laststate
      valid = false
      break
    end
    laststate = thisstate
  end
  valid
end

def alternatingvowelsconsonants(a)
  c2 = common_substring(a).select{|x| is_avc(x)}
  if c2.length > 0
    l = c2[0].length
    c2.select{|x| x.length == l}
  else
    []
  end
end

require 'test/unit'

class TestAlternatingvowelsconsonants < Test::Unit::TestCase

  def test_ex1
    assert_equal(['locate'], alternatingvowelsconsonants(['relocate', 'delocate', 'allocate']))
  end

  def test_ex2
    assert_equal([], alternatingvowelsconsonants(['apple', 'banana', 'cherry']))
  end

  def test_ex3
    assert_equal(['avi'], alternatingvowelsconsonants(['navigate', 'cavity', 'gravity']))
  end

  def test_ex4
    assert_equal(['peda'], alternatingvowelsconsonants(['pedalgia', 'pedalboard', 'pedantic']))
  end

  def test_ex5
    assert_equal(['ho', 'ol'], alternatingvowelsconsonants(['schoolmaster', 'schoolhouse', 'schooling']))
  end

end
