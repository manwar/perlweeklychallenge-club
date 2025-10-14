#! /usr/bin/ruby

def zerofriend(a)
  b = a.map { |x| x.abs }.min
  if a.include?(b)
    return b
  end
  -b
end

require 'test/unit'

class TestZerofriend < Test::Unit::TestCase

  def test_ex1
    assert_equal(-1, zerofriend([4, 2, -1, 3, -2]))
  end

  def test_ex2
    assert_equal(1, zerofriend([-5, 5, -3, 3, -1, 1]))
  end

  def test_ex3
    assert_equal(0, zerofriend([7, -3, 0, 2, -8]))
  end

  def test_ex4
    assert_equal(-1, zerofriend([-2, -5, -1, -8]))
  end

  def test_ex5
    assert_equal(1, zerofriend([-2, 2, -4, 4, -1, 1]))
  end

end
