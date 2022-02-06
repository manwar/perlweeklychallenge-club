#! /usr/bin/ruby

require 'test/unit'

def fibstr(aa,bb,limit)
  a=aa
  b=bb
  while true do
    c=a+b
    print("#{c}\n")
    if c.length >= limit then
      return c[limit-1]
    end
    a=b
    b=c
  end
end

class TestFibstr < Test::Unit::TestCase

  def test_ex1
    assert_equal("7",fibstr("1234","5678",51))
  end

end
