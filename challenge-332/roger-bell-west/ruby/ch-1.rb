#! /usr/bin/ruby

def binarydate(a)
  a.split("-").map{|n| n.to_i.to_s(2)}.join("-")
end

require 'test/unit'

class TestBinarydate < Test::Unit::TestCase

  def test_ex1
    assert_equal('11111101001-111-11010', binarydate('2025-07-26'))
  end

  def test_ex2
    assert_equal('11111010000-10-10', binarydate('2000-02-02'))
  end

  def test_ex3
    assert_equal('11111101000-1100-11111', binarydate('2024-12-31'))
  end

end
