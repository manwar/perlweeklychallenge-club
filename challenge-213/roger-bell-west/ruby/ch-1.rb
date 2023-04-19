#! /usr/bin/ruby

require 'test/unit'

def funsort(l0)
  l = l0.sort
  a = []
  b = []
  l.each do |k|
    if k % 2 == 0 then
      a.push(k)
    else
      b.push(k)
    end
  end
  a.concat(b)
  return a
end

class TestFunsort < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 4, 6, 1, 3, 5], funsort([1, 2, 3, 4, 5, 6]))
  end

  def test_ex2
    assert_equal([2, 1], funsort([1, 2]))
  end

  def test_ex3
    assert_equal([1], funsort([1]))
  end

end
