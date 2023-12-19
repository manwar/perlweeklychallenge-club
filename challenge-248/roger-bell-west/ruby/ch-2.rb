#! /usr/bin/ruby

def submatrixsum(a)
  out = []
  0.upto(a.length - 2) do |y|
    row = []
    0.upto(a[y].length - 2) do |x|
      s = 0
      y.upto(y + 1) do |ya|
        x.upto(x + 1) do |xa|
          s += a[ya][xa]
        end
      end
      row.push(s)
    end
    out.push(row)
  end
  return out
end


require 'test/unit'

class TestSubmatrixsum < Test::Unit::TestCase

  def test_ex1
    assert_equal([[14, 18, 22], [30, 34, 38]], submatrixsum([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]))
  end

  def test_ex2
    assert_equal([[2, 1, 0], [1, 2, 1], [0, 1, 2]], submatrixsum([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]))
  end

end
