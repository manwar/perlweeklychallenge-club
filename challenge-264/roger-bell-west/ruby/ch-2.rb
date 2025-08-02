#! /usr/bin/ruby

def targetarray(a, indices)
  c = []
  indices.each_with_index do |ix, i|
    if ix == c.length() then
      c.push(a[i])
    else
      c[ix, 0] = a[i]
    end
  end
  return c
end

require 'test/unit'

class TestTargetarray < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 4, 1, 3, 2], targetarray([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]))
  end

  def test_ex2
    assert_equal([0, 1, 2, 3, 4], targetarray([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]))
  end

  def test_ex3
    assert_equal([1], targetarray([1], [0]))
  end

end
