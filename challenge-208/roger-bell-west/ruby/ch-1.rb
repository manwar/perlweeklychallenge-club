#! /usr/bin/ruby

require 'test/unit'

def v2hm(a)
  h = Hash.new
  a.each_with_index do |x, i|
    if !h.has_key?(x) then
      h[x] = i
    end
  end
  return h
end

def minindexsum(a, b)
  ah = v2hm(a)
  bh = v2hm(b)
  out = []
  mi = a.length + b.length
  a.each do |w|
    if bh.has_key?(w) then
      mv = ah[w] + bh[w]
      if mv < mi then
        out = []
        mi = mv
      end
      if mv == mi then
        out.push(w)
      end
    end
  end
  return out
end
        

class TestMinindexsum < Test::Unit::TestCase

  def test_ex1
    assert_equal(['Perl', 'Raku'], minindexsum(['Perl', 'Raku', 'Love'], ['Raku', 'Perl', 'Hate']))
  end

  def test_ex2
    assert_equal([], minindexsum(['A', 'B', 'C'], ['D', 'E', 'F']))
  end

  def test_ex3
    assert_equal(['A'], minindexsum(['A', 'B', 'C'], ['C', 'A', 'B']))
  end

end
