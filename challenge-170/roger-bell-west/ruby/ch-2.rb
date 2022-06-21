#! /usr/bin/ruby

require 'test/unit'

def kronecker(a,b)
  o = []
  ax = a[0].length
  ay = a.length
  bx = b[0].length
  by = b.length
  0.upto(ay*by-1) do |y|
    ayi,byi = y.divmod(by)
    row = []
    0.upto(ax*bx-1) do |x|
      axi,bxi = x.divmod(bx)
      row.push(a[ayi][axi] * b[byi][bxi])
    end
    o.push(row)
  end
  return o
end

class TestKronecker < Test::Unit::TestCase

  def test_ex1
    assert_equal([
                   [ 5,  6, 10, 12],
                   [ 7,  8, 14, 16],
                   [15, 18, 20, 24],
                   [21, 24, 28, 32]
                 ],
                 kronecker([[1,2],[3,4]],
                           [[5,6],[7,8]])
                )
  end

end
