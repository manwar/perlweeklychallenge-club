#! /usr/bin/ruby

require 'test/unit'

require 'set'

def binarystring(n)
  fmt = "%0" + n.to_s + "b"
  o = []
  0.upto((1 << n)-1) do |a|
    o.push(sprintf(fmt, a))
  end
  return o
end

class TestBinarystring < Test::Unit::TestCase

  def test_ex1
    assert_equal(["00", "01", "10", "11"], binarystring(2));
  end

  def test_ex2
    assert_equal(["000", "001", "010", "011", "100", "101", "110", "111"], binarystring(3));
  end
end
