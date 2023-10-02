#! /usr/bin/ruby

def seniorcitizens(a)
  return a.count {|x| x[11] >= "6"}
end

require 'test/unit'

class TestSeniorcitizens < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, seniorcitizens(['7868190130M7522', '5303914400F9211', '9273338290F4010']))
  end

  def test_ex2
    assert_equal(0, seniorcitizens(['1313579440F2036', '2921522980M5644']))
  end

end
