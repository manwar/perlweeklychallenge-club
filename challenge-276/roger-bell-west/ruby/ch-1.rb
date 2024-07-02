#! /usr/bin/ruby

def completeday(a)
  return a.combination(2).find_all{|c| (c[0] + c[1]) % 24 == 0}.length
end

require 'test/unit'

class TestCompleteday < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, completeday([12, 12, 30, 24, 24]))
  end

  def test_ex2
    assert_equal(3, completeday([72, 48, 24, 5]))
  end

  def test_ex3
    assert_equal(0, completeday([12, 18, 24]))
  end

end
