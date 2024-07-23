#! /usr/bin/ruby

def splitstring(a)
  n = 0
  a.downcase.chars.each do |cc|
    n += case cc
         when 'a', 'e', 'i', 'o', 'u'
           1
         else
           0
         end
  end
  n % 2 == 0
end

require 'test/unit'

class TestSplitstring < Test::Unit::TestCase

  def test_ex1
    assert_equal(false, splitstring('perl'))
  end

  def test_ex2
    assert_equal(true, splitstring('book'))
  end

  def test_ex3
    assert_equal(true, splitstring('goodmorning'))
  end

end
