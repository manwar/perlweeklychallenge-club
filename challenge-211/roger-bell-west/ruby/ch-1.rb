#! /usr/bin/ruby

require 'test/unit'

def toeplitzmatrix(a)
  ym = a.length - 1
  xm = a[0].length - 1
  toeplitz = true
  (-xm + 1).upto(ym - 1) do |xb|
    init = true
    tv = 0
    xb.upto(xb + xm) do |x|
      if x >= 0 && x <= xm then
        y = x - xb
        if y >= 0 && y <= ym then
          if init then
            init = false
            tv = a[y][x]
          elsif a[y][x] != tv then
            toeplitz = false
            break
          end
        end
      end
    end
    if !toeplitz then
      break
    end
  end
  return toeplitz
end

class TestToeplitzmatrix < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, toeplitzmatrix([[4, 3, 2, 1], [5, 4, 3, 2], [6, 5, 4, 3]]))
  end

  def test_ex2
    assert_equal(false, toeplitzmatrix([[1, 2, 3], [3, 2, 1]]))
  end

end
