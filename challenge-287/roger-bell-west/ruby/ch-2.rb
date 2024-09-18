#! /usr/bin/ruby

def validnumber(a)
  integer = "[-+]?[0-9]+"
  float = "[-+]?([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)"
  exponential =
    "(" + integer + "|" + float + ")[Ee]" + integer
  number =
    "^(" + integer + "|" + float + "|" + exponential + ")$"
  rx = Regexp.new(number)
  if rx.match(a)
    return true
  end
  false
end

require 'test/unit'

class TestValidnumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, validnumber('1'))
  end

  def test_ex2
    assert_equal(false, validnumber('a'))
  end

  def test_ex3
    assert_equal(false, validnumber('.'))
  end

  def test_ex4
    assert_equal(false, validnumber('1.2e4.2'))
  end

  def test_ex5
    assert_equal(true, validnumber('-1.'))
  end

  def test_ex6
    assert_equal(true, validnumber('+1E-8'))
  end

  def test_ex7
    assert_equal(true, validnumber('.44'))
  end

end
