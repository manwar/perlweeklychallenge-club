#! /usr/bin/ruby

def maximumproduct(lst)
  l = lst.sort
  b = l.length
  t = []
  0.upto(3) do |i|
    p = 1
    if i > 0 then
      0.upto(i-1) do |j|
        p *= l[j]
      end
    end
    if i < 3 then
      (b - 3 + i).upto(b-1) do |j|
        p *= l[j]
      end
    end
    t.push(p)
  end
  return t.max
end

require 'test/unit'

class TestMaximumproduct < Test::Unit::TestCase

  def test_ex1
    assert_equal(6, maximumproduct([3, 1, 2]))
  end

  def test_ex2
    assert_equal(24, maximumproduct([4, 1, 3, 2]))
  end

  def test_ex3
    assert_equal(3, maximumproduct([-1, 0, 1, 3, 1]))
  end

  def test_ex4
    assert_equal(216, maximumproduct([-8, 2, -9, 0, -4, 3]))
  end

end
