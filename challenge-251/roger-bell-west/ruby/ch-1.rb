#! /usr/bin/ruby

def concat(a0, b0)
  if (b0 == 0) then
    return 10 * a0
  end
  a = a0
  b = b0
  while (b > 0) do
    a *= 10;
    b = (b / 10).floor
  end
  return a + b0
end

def concatenationvalue(a)
  t = 0
  0.upto(((a.length - 1) / 2).floor) do |i|
    j = a.length - 1 - i
    if (j == i) then
      t += a[i]
    else
      t += concat(a[i], a[j])
    end
  end
  return t
end

require 'test/unit'

class TestConcatenationvalue < Test::Unit::TestCase

  def test_ex1
    assert_equal(1286, concatenationvalue([6, 12, 25, 1]))
  end

  def test_ex2
    assert_equal(489, concatenationvalue([10, 7, 31, 5, 2, 2]))
  end

  def test_ex3
    assert_equal(112, concatenationvalue([1, 2, 10]))
  end

end
