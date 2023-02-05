#! /usr/bin/ruby

require 'test/unit'

def consecutiveodds(a)
  i = 0
  a.each do |v|
    if v % 2 == 1 then
      i += 1
      if i >= 3 then
        return true
      end
    else
      i = 0
    end
  end
  return false
end

class TestConsecutiveodds < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, consecutiveodds([1, 5, 3, 6]))
  end

  def test_ex2
    assert_equal(false, consecutiveodds([2, 6, 3, 5]))
  end

  def test_ex3
    assert_equal(false, consecutiveodds([1, 2, 3, 4]))
  end

  def test_ex4
    assert_equal(true, consecutiveodds([2, 3, 5, 7]))
  end

end
