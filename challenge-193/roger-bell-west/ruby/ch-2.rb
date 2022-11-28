#! /usr/bin/ruby

require 'test/unit'

def oddstring(ss)
  0.upto(ss[0].length-2) do |i|
    tab = Hash.new
    ss.each do |s|
      v = s[i+1].ord - s[i].ord
      l = []
      if tab.has_key?(v) then
        l = tab[v]
      end
      l.push(s)
      tab[v] = l
    end
    tab.values().each do |j|
      if j.length == 1 then
        return j[0]
      end
    end
  end
  return ""
end

class TestOddstring < Test::Unit::TestCase

  def test_ex1
    assert_equal("abc", oddstring(["adc", "wzy", "abc"]))
  end

  def test_ex2
    assert_equal("bob", oddstring(["aaa", "bob", "ccc", "ddd"]))
  end
end
