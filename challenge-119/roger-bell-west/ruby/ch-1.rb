#! /usr/bin/ruby

def sn(n)
  t=n.divmod(16)
  return 16*t[1]+t[0]
end

require 'test/unit'

class TestSn < Test::Unit::TestCase

  def test_ex1
    assert_equal(86,sn(101))
  end
  
  def test_ex2
    assert_equal(33,sn(18))
  end
  
end
