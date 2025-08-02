#! /usr/bin/ruby

def maximumones(a)
  ax = a.map { |r| r.sum }
  am = ax.max
  ax.each_with_index do |n, i|
    if n == am then
      return i + 1
    end
  end
  return 0
end

require 'test/unit'

class TestMaximumones < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, maximumones([[0, 1], [1, 0]]))
  end

  def test_ex2
    assert_equal(2, maximumones([[0, 0, 0], [1, 0, 1]]))
  end

  def test_ex3
    assert_equal(2, maximumones([[0, 0], [1, 1], [0, 0]]))
  end

end
