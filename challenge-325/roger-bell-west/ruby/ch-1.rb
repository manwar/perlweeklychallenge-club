#! /usr/bin/ruby

def consecutiveone(a)
  h = Hash.new
  h[0] = 0
  latch = 0
  latched = false
  a.each_with_index do |n, i|
    if n == 1 && !latched
      latched = true
      latch = i
    end
    if n == 0 && latched
      latched = false
      h[latch] = i - latch
    end
  end
  if latched
    h[latch] = a.length - latch
  end
  h.values.max
end

require 'test/unit'

class TestConsecutiveone < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, consecutiveone([0, 1, 1, 0, 1, 1, 1]))
  end

  def test_ex2
    assert_equal(0, consecutiveone([0, 0, 0, 0]))
  end

  def test_ex3
    assert_equal(2, consecutiveone([1, 0, 1, 0, 1, 1]))
  end

end
