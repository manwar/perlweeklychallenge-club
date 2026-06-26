#! /usr/bin/ruby

def armstrongnumber(base, limit)
  out = []
  0.upto(limit - 1) do |candidate|
    digits = []
    if candidate == 0
      digits.push(0)
    else
      c = candidate
      while c > 0
        c, x = c.divmod(base)
        digits.push(x)
      end
    end
    dl = digits.size
    test = digits.map{|x| x ** dl}.sum
    if test == candidate
      out.push(candidate)
    end
  end
  out
end

require 'test/unit'

class TestArmstrongnumber < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407], armstrongnumber(10, 1000))
  end

  def test_ex2
    assert_equal([0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250], armstrongnumber(7, 1000))
  end

  def test_ex3
    assert_equal([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645], armstrongnumber(16, 1000))
  end

end
