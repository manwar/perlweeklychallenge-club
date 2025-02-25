#! /usr/bin/ruby

def maximalsquare(a)
  mx = 0
  boundy = a.length
  boundx = a[0].length
  0.upto(boundy - 1) do |y|
    0.upto(boundx - 1) do |x|
      size = 0
      while true do
        tests = []
        x.upto(x + size) do |xx|
          tests.push([y + size, xx])
        end
        if size > 0
          y.upto(y + size - 1) do |yy|
            tests.push([yy, x + size])
          end
        end
        if tests.map { |yx| a[yx[0]][yx[1]] }.any?{|n| n == 0}
          break
        end
        size += 1
        if x + size >= boundx || y + size >= boundy
          break
        end
      end
      mx = [mx, size * size].max
    end
  end
  mx
end

require 'test/unit'

class TestMaximalsquare < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, maximalsquare([[1, 0, 1, 0, 0], [1, 0, 1, 1, 1], [1, 1, 1, 1, 1], [1, 0, 0, 1, 0]]))
  end

  def test_ex2
    assert_equal(1, maximalsquare([[0, 1], [1, 0]]))
  end

  def test_ex3
    assert_equal(0, maximalsquare([[0]]))
  end

end
