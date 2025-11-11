#! /usr/bin/ruby

def longestparenthesis(aa)
  a = aa.chars
  ml = 0
  0.upto(a.size - 1) do |l|
    l.upto(a.size - 1) do |r|
      depth = 0
      valid = true
      l.upto(r) do |i|
        if a[i] == '('
          depth += 1
        else
          depth -= 1
          if depth < 0
            valud = false
            break
          end
        end
      end
      if depth != 0
        valid = false
      end
      if valid
        ml = [ml, r - l + 1].max
      end
    end
  end
  ml
end

require 'test/unit'

class TestLongestparenthesis < Test::Unit::TestCase

  def test_ex1
    assert_equal(6, longestparenthesis('(()())'))
  end

  def test_ex2
    assert_equal(4, longestparenthesis(')()())'))
  end

  def test_ex3
    assert_equal(8, longestparenthesis('((()))()(((()'))
  end

  def test_ex4
    assert_equal(2, longestparenthesis('))))((()('))
  end

  def test_ex5
    assert_equal(2, longestparenthesis('()(()'))
  end

end
