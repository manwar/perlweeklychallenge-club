#! /usr/bin/ruby

require 'test/unit'

def specialintegers(n)
  o = 0
  1.upto(n) do |i|
    f = Hash.new(0)
    for c in i.to_s.chars do
      f[c] += 1
    end
    if f.values.max == 1 then
      o += 1
    end
  end
  return o
end

class TestSpecialintegers < Test::Unit::TestCase

  def test_ex1
    assert_equal(14, specialintegers(15))
  end

  def test_ex2
    assert_equal(32, specialintegers(35))
  end

end
