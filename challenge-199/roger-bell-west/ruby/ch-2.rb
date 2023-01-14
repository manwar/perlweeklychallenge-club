#! /usr/bin/ruby

require 'test/unit'

def goodtriplets(a, x, y, z)
  c = 0
  0.upto(a.length - 3) do |i|
    (i + 1).upto(a.length - 2) do |j|
      if (a[i] - a[j]).abs <= x then
        (j + 1).upto(a.length - 1) do |k|
          if (a[j] - a[k]).abs <= y &&
             (a[i] - a[k]).abs <= z then
            c += 1
          end
        end
      end
    end
  end
  return c
end

class TestGoodtriplets < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, goodtriplets([3, 0, 1, 1, 9, 7], 7, 2, 3))
  end

  def test_ex2
    assert_equal(0, goodtriplets([1, 1, 2, 2, 3], 0, 0, 1))
  end

end
