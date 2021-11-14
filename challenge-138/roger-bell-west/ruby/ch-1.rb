#! /usr/bin/ruby

def p(y)
  return (y+y.div(4)-y.div(100)+y.div(400)) % 7
end

def leapyear(y)
  return y%4==0 && (y%100!=0 || y%400==0)
end

def workdays(y)
  i=p(y)
  if leapyear(y) then
    i+=7
  end
  return 260+[0,1,1,1,1,0,0,1,2,2,2,2,1][i]
end

require 'test/unit'

class TestWorkdays < Test::Unit::TestCase

  def test_ex1
    assert_equal(260,workdays(2021))
  end

  def test_ex2
    assert_equal(262,workdays(2020))
  end

end
