#! /usr/bin/ruby

def jg(n)
  mx=n.length-1
  p=0
  while (1) do
    p += n[p]
    if p == mx
      return 1
    elsif p > mx or n[p]==0
      return 0
    end
  end
end

require 'test/unit'

class TestJg < Test::Unit::TestCase

  def test_ex1
    assert_equal(jg([1,2,1,2]),1)
  end

  def test_ex2
    assert_equal(jg([2,1,1,0,2]),0)
  end

end
