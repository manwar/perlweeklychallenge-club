#! /usr/bin/ruby

def specialaverage(a0)
  a = a0.sort
  min = a[0]
  max = a[-1]
  b = a.select{|x| x != min && x != max}
  if b.size == 0
    return 0
  end
  return b.sum / b.size
end

require 'test/unit'

class TestSpecialaverage < Test::Unit::TestCase

  def test_ex1
    assert_equal(5250, specialaverage([8000, 5000, 6000, 2000, 3000, 7000]))
  end

  def test_ex2
    assert_equal(95000, specialaverage([100000, 80000, 110000, 90000]))
  end

  def test_ex3
    assert_equal(0, specialaverage([2500, 2500, 2500, 2500]))
  end

  def test_ex4
    assert_equal(0, specialaverage([2000]))
  end

  def test_ex5
    assert_equal(3500, specialaverage([1000, 2000, 3000, 4000, 5000, 6000]))
  end

end
