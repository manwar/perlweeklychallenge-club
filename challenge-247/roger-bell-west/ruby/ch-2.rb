#! /usr/bin/ruby

def mostfrequentletterpair(s)
  f = Hash.new
  0.upto(s.length - 2) do |i|
    pair = s[i, 2]
    if  f.has_key?(pair) then
      f[pair] += 1
    else
      f[pair] = 1
    end
  end
  m = f.values.max
  l = f.keys.find_all{|i| f[i] == m}
  l.sort!
  return l[0]
end

require 'test/unit'

class TestMostfrequentletterpair < Test::Unit::TestCase

  def test_ex1
    assert_equal('bc', mostfrequentletterpair('abcdbca'))
  end

  def test_ex2
    assert_equal('ab', mostfrequentletterpair('cdeabeabfcdfabgcd'))
  end

end
