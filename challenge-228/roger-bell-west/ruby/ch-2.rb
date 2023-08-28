#! /usr/bin/ruby

def emptyarray(a0)
  t = 0
  a = a0
  while a.length > 0 do
    mn = a.min
    0.upto(a.length - 1) do |i|
      if a[i] == mn then
        t += i + 1
        a.delete_at(i)
        break
      end
    end
  end
  return t
end

require 'test/unit'

class TestEmptyarray < Test::Unit::TestCase

  def test_ex1
    assert_equal(5, emptyarray([3, 4, 2]))
  end

  def test_ex2
    assert_equal(3, emptyarray([1, 2, 3]))
  end

end
