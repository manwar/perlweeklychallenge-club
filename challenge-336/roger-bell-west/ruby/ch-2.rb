#! /usr/bin/ruby

def finalscore(a)
  p = []
  a.each do |n|
    if n == "C"
      p.pop
    elsif n == "D"
      p.push(2 * p[-1])
    elsif n == "+"
      p.push(p[-2] + p[-1])
    else
      p.push(n.to_i)
    end
  end
  p.sum
end

require 'test/unit'

class TestFinalscore < Test::Unit::TestCase

  def test_ex1
    assert_equal(30, finalscore(['5', '2', 'C', 'D', '+']))
  end

  def test_ex2
    assert_equal(27, finalscore(['5', '-2', '4', 'C', 'D', '9', '+', '+']))
  end

  def test_ex3
    assert_equal(45, finalscore(['7', 'D', 'D', 'C', '+', '3']))
  end

  def test_ex4
    assert_equal(-55, finalscore(['-5', '-10', '+', 'D', 'C', '+']))
  end

  def test_ex5
    assert_equal(128, finalscore(['3', '6', '+', 'D', 'C', '8', '+', 'D', '-2', 'C', '+']))
  end

end
