#! /usr/bin/ruby

def runningsum(a)
  b = a
  a.each_index do |i|
    if i > 0 then
      b[i] += b[i - 1]
    end
  end
  return b
end

require 'test/unit'

class TestRunningsum < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 3, 6, 10, 15], runningsum([1, 2, 3, 4, 5]))
  end

  def test_ex2
    assert_equal([1, 2, 3, 4, 5], runningsum([1, 1, 1, 1, 1]))
  end

  def test_ex3
    assert_equal([0, -1, 0, 2], runningsum([0, -1, 1, 2]))
  end

end
