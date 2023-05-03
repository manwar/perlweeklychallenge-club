#! /usr/bin/ruby

require 'test/unit'

def numberplacement(a0, ct)
  a = a0
  a.unshift(1)
  a.push(1)
  s = 0
  tt = 0
  1.upto(a.length) do |i|
    if a[i - 1] == 1 && a[i] == 0 then
      s = i
    elsif a[i - 1] == 0 && a[i] == 1 then
      tt += ((i - s) / 2).to_i
    end
  end
  return ct <= tt
end

class TestNumberplacement < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, numberplacement([1, 0, 0, 0, 1], 1))
  end

  def test_ex2
    assert_equal(false, numberplacement([1, 0, 0, 0, 1], 2))
  end

  def test_ex3
    assert_equal(true, numberplacement([1, 0, 0, 0, 0, 0, 0, 0, 1], 3))
  end

end
