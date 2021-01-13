#! /usr/bin/ruby

require 'set'

def ga(*l)
  g=Hash.new
  l.each do |word|
    h=wh(word)
    if !g.has_key?(h) then
      g[h]=Set.new;
    end
    g[h] << word
  end
  r=Set.new
  g.values().each do |v|
    r << v
  end
  return r
end

def wh(word)
  w=word.downcase
  if w =~ /[^a-z]/ then
    return 0
  end
  b='a'.ord
  p=[2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101]
  n=1
  w.chars do |c|
    n *= p[c.ord-b]
  end
  return n
end

require 'test/unit'

class TestGa < Test::Unit::TestCase

  def test_ex1
    assert_equal(Set.new([Set.new(['bat','tab']),Set.new(['opt','pot','top']),Set.new(['saw','was'])]),ga('opt','bat','saw','tab','pot','top','was'))
  end

  def test_ex2
    assert_equal(Set.new([Set.new(["x"])]),ga('x'))
  end

end
