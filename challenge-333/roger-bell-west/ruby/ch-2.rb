#! /usr/bin/ruby

def duplicatezeros(a)
  b = []
  a.each do |n|
    b.push(n)
    if a.size == b.size
      break
    end
    if n == 0
      b.push(0)
      if a.size == b.size
        break
      end
    end
  end
  b
end

require 'test/unit'

class TestDuplicatezeros < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 0, 0, 2, 3, 0, 0, 4], duplicatezeros([1, 0, 2, 3, 0, 4, 5, 0]))
  end

  def test_ex2
    assert_equal([1, 2, 3], duplicatezeros([1, 2, 3]))
  end

  def test_ex3
    assert_equal([1, 2, 3, 0], duplicatezeros([1, 2, 3, 0]))
  end

  def test_ex4
    assert_equal([0, 0, 0, 0], duplicatezeros([0, 0, 1, 2]))
  end

  def test_ex5
    assert_equal([1, 2, 0, 0, 3], duplicatezeros([1, 2, 0, 3, 4]))
  end

end
