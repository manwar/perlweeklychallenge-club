#! /usr/bin/ruby

def goalparser(a)
  out = ""
  s = 0
  while s < a.size
    if a[s..-1].start_with?("G")
      s += 1
      out += "G"
    elsif a[s..-1].start_with?("()")
      s += 2
      out += "o"
    elsif a[s..-1].start_with?("(al)")
      s += 4
      out += "al"
    else
      return ""
    end
  end
  out
end

require 'test/unit'

class TestGoalparser < Test::Unit::TestCase

  def test_ex1
    assert_equal('Goal', goalparser('G()(al)'))
  end

  def test_ex2
    assert_equal('Gooooal', goalparser('G()()()()(al)'))
  end

  def test_ex3
    assert_equal('alGaloo', goalparser('(al)G(al)()()'))
  end

  def test_ex4
    assert_equal('oGoG', goalparser('()G()G'))
  end

  def test_ex5
    assert_equal('alalGoo', goalparser('(al)(al)G()()'))
  end

end
