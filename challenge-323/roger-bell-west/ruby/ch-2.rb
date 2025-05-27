#! /usr/bin/ruby

def taxamount(income, brackets)
  tax = 0
  lastbracket = 0
  brackets.each do |bracket|
    if income > lastbracket
      tax += ([income, bracket[0]].min - lastbracket) * bracket[1]
    else
      break
    end
    lastbracket = bracket[0]
  end
  tax / 100.0
end

require 'test/unit'

class TestTaxamount < Test::Unit::TestCase

  def test_ex1
    assert_equal(2.65, taxamount(10, [[3, 50], [7, 10], [12, 25]]))
  end

  def test_ex2
    assert_equal(0.25, taxamount(2, [[1, 0], [4, 25], [5, 50]]))
  end

  def test_ex3
    assert_equal(0, taxamount(0, [[2, 50]]))
  end

end
