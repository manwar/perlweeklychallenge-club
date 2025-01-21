#! /usr/bin/ruby

def aliendictionary(a, dc)
  mxl = a.map { |x| x.length }.max
  dh = Hash.new
  dc.each_with_index do |c, i|
    dh[c] = i
  end
  b = a
  numerics = Hash.new
  b.each do |w|
    n = 0
    cc = w.chars
    0.upto(mxl - 1) do |i|
      n *= 27
      if i < w.length
        n += dh[cc[i]]
      end
    end
    numerics[w] = n
  end
  b.sort! do |i, j|
    numerics[i] <=> numerics[j]
  end
  b
end

require 'test/unit'

class TestAliendictionary < Test::Unit::TestCase

  def test_ex1
    assert_equal(['raku', 'python', 'perl'], aliendictionary(['perl', 'python', 'raku'], ['h', 'l', 'a', 'b', 'y', 'd', 'e', 'f', 'g', 'i', 'r', 'k', 'm', 'n', 'o', 'p', 'q', 'j', 's', 't', 'u', 'v', 'w', 'x', 'c', 'z']))
  end

  def test_ex2
    assert_equal(['challenge', 'the', 'weekly'], aliendictionary(['the', 'weekly', 'challenge'], ['c', 'o', 'r', 'l', 'd', 'a', 'b', 't', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm', 'n', 'p', 'q', 's', 'w', 'u', 'v', 'x', 'y', 'z']))
  end

end
