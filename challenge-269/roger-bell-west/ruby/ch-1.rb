#! /usr/bin/ruby

def bitwiseor(a)
  a.select{|n| n % 2 == 0}.size >= 2
end

require 'test/unit'

class TestBitwiseor < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, bitwiseor([1, 2, 3, 4, 5]))
  end

  def test_ex2
    assert_equal(true, bitwiseor([2, 3, 8, 16]))
  end

  def test_ex3
    assert_equal(false, bitwiseor([1, 2, 5, 7, 9]))
  end

end
