#! /usr/bin/ruby

def duplicateremovals(a)
  b = Array.new
  a.chars.each do |c|
    if b.size == 0 || c != b[-1]
      b.push(c)
    else
      b.pop
    end
  end
  b.join("")
end

require 'test/unit'

class TestDuplicateremovals < Test::Unit::TestCase

  def test_ex1
    assert_equal('ca', duplicateremovals('abbaca'))
  end

  def test_ex2
    assert_equal('ay', duplicateremovals('azxxzy'))
  end

  def test_ex3
    assert_equal('', duplicateremovals('aaaaaaaa'))
  end

  def test_ex4
    assert_equal('a', duplicateremovals('aabccba'))
  end

  def test_ex5
    assert_equal('', duplicateremovals('abcddcba'))
  end

end
