#! /usr/bin/ruby

def seob(n)
  return ((n & 0x55)<<1) | ((n & 0xAA)>>1)
end

require 'test/unit'

class TestSeob < Test::Unit::TestCase

  def test_ex1
    assert_equal(154,seob(101))
  end
  
  def test_ex2
    assert_equal(33,seob(18))
  end
  
end
