#! /usr/bin/ruby

def jortsort(a)
  a.each_cons(2) { |i|
    if i[0] > i[1] then
      return false
    end
  }
  return true
end

require 'test/unit'

class TestJortsort < Test::Unit::TestCase

  def test_ex1
    assert_equal(true,jortsort([1,2,3,4,5]))
  end

  def test_ex2
    assert_equal(false,jortsort([1,3,2,4,5]))
  end

end
