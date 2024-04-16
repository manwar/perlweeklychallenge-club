#! /usr/bin/ruby

def thirtythreepercentappearance(a)
  c = Hash.new(0)
  a.each do |n|
    c[n] += 1
  end
  threshold = (a.length * 33 / 100).floor
  if (threshold * 100 / 33).floor != a.length then
    threshold += 1
  end
  return c.keys.find_all{|k| c[k] >= threshold}.min
end

require 'test/unit'

class TestThirtythreepercentappearance < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, thirtythreepercentappearance([1, 2, 3, 3, 3, 4, 2]))
  end

  def test_ex2
    assert_equal(1, thirtythreepercentappearance([1, 1]))
  end

  def test_ex3
    assert_equal(1, thirtythreepercentappearance([1, 2, 3]))
  end

end
