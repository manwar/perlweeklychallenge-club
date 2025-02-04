#! /usr/bin/ruby

def findanagrams(a)
  b = a.map{|x| x.chars.sort.join}
  out = 1
  b.each_cons(2) do |s|
    if s[0] != s[1]
      out += 1
    end
  end
  out
end

require 'test/unit'

class TestFindanagrams < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, findanagrams(['acca', 'dog', 'god', 'perl', 'repl']))
  end

  def test_ex2
    assert_equal(2, findanagrams(['abba', 'baba', 'aabb', 'ab', 'ab']))
  end

end
