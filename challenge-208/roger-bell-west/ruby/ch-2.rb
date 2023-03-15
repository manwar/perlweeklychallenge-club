#! /usr/bin/ruby

require 'test/unit'

def duplicateandmissing(a)
  flags = 0
  dup = 0
  mis = 0
  exp = a[0]
  a.each do |n|
    if n < exp then
      dup = n
      flags |= 1
    elsif n > exp then
      mis = exp
      flags |= 2
    end
    if flags == 3 then
      return [dup, mis]
    end
    exp = n + 1
  end
  if flags == 1 then
    return [dup, exp]
  end
  return [-1]
end

class TestDuplicateandmissing < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 3], duplicateandmissing([1, 2, 2, 4]))
  end

  def test_ex2
    assert_equal([-1], duplicateandmissing([1, 2, 3, 4]))
  end

  def test_ex3
    assert_equal([3, 4], duplicateandmissing([1, 2, 3, 3]))
  end

end
