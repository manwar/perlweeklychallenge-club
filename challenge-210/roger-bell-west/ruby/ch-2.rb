#! /usr/bin/ruby

require 'test/unit'

def numbercollision(aa)
  a = aa
  dirty = true
  while dirty do
    b = []
    dirty = false
    i = 0
    while i + 1 <= a.length do
      if i + 1 < a.length && a[i] > 0 && a[i + 1] < 0 then
        ab = a[i + 1].abs
        if a[i] > ab then
          b.push(a[i])
        elsif a[i] < ab then
          b.push(a[i + 1])
        end
        i += 2
        dirty = true
      else
        b.push(a[i])
        i += 1
      end
    end
    a = b;
  end
  return a
end

class TestNumbercollision < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 3], numbercollision([2, 3, -1]))
  end

  def test_ex2
    assert_equal([-4], numbercollision([3, 2, -4]))
  end

  def test_ex3
    assert_equal([], numbercollision([1, -1]))
  end

end
