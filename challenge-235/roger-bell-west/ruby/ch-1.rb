#! /usr/bin/ruby

def removeone(a)
  ec = 0
  le = 1 + a[1] - a[0]
  a.each_cons(2) do |s|
    if s[1] <= s[0] then
      ec += 1
      if ec > 1 || s[0] - s[1] >= le then
        return false
      end
    end
    le = s[1] - s[0]
  end
  return true
end

require 'test/unit'

class TestRemoveone < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, removeone([0, 2, 9, 4, 6]))
  end

  def test_ex2
    assert_equal(false, removeone([5, 1, 3, 2]))
  end

  def test_ex3
    assert_equal(true, removeone([2, 2, 3]))
  end

end
