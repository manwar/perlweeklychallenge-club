#! /usr/bin/ruby

require 'set'

def dictionaryrank(a)
  c = a.split('')
  d = Set.new
  c.permutation do |o|
    d.add(o.join(''))
  end
  dd = d.to_a.sort
  dd.each_with_index do |s, i|
    if s == a then
      return i + 1
    end
  end
  return 0
end

require 'test/unit'

class TestDictionaryrank < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, dictionaryrank('CAT'))
  end

  def test_ex2
    assert_equal(88, dictionaryrank('GOOGLE'))
  end

  def test_ex3
    assert_equal(255, dictionaryrank('SECRET'))
  end

end
