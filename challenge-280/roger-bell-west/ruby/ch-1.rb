#! /usr/bin/ruby

require 'set'

def twiceappearance(a)
  m = Set.new
  a.chars.each do |c|
    if m.include?(c)
      return c
    end
    m.add(c)
  end
  return 'x'
end

require 'test/unit'

class TestTwiceappearance < Test::Unit::TestCase

  def test_ex1
    assert_equal('d', twiceappearance('acbddbca'))
  end

  def test_ex2
    assert_equal('c', twiceappearance('abccd'))
  end

  def test_ex3
    assert_equal('a', twiceappearance('abcdabbb'))
  end

end
