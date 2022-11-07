#! /usr/bin/ruby

require 'test/unit'

def capitaldetection(s)
  if /^([A-Z]+|[a-z]+|[A-Z][a-z]+)$/.match(s) then
    return true
  else
    return false
  end
end

class TestDivisiblepairs < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, capitaldetection("Perl"))
  end

  def test_ex2
    assert_equal(true, capitaldetection("TPF"))
  end

  def test_ex3
    assert_equal(false, capitaldetection("PyThon"))
  end

  def test_ex4
    assert_equal(true, capitaldetection("raku"))
  end
end
