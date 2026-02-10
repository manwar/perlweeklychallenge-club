#! /usr/bin/ruby

def textjustifier(intxt, width)
  working = Array.new(width, '*')
  offset = ((width - intxt.size) / 2).to_i
  intxt.chars().each_with_index do |c, i|
    working[i + offset] = c
  end
  working.join("")
end

require 'test/unit'

class TestTextjustifier < Test::Unit::TestCase

  def test_ex1
    assert_equal('*Hi**', textjustifier('Hi', 5))
  end

  def test_ex2
    assert_equal('***Code***', textjustifier('Code', 10))
  end

  def test_ex3
    assert_equal('**Hello**', textjustifier('Hello', 9))
  end

  def test_ex4
    assert_equal('Perl', textjustifier('Perl', 4))
  end

  def test_ex5
    assert_equal('***A***', textjustifier('A', 7))
  end

  def test_ex6
    assert_equal('*****', textjustifier('', 5))
  end

end
