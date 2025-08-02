#! /usr/bin/ruby

def counterify(a)
  cc = Hash.new
  cc.default = 0
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def oddletters(a)
  c = counterify(a.chars)
  c.values.all? { |v| v % 2 == 1 }
end

require 'test/unit'

class TestOddletters < Test::Unit::TestCase

  def test_ex1
    assert_equal(false, oddletters('weekly'))
  end

  def test_ex2
    assert_equal(true, oddletters('perl'))
  end

  def test_ex3
    assert_equal(false, oddletters('challenge'))
  end

end
