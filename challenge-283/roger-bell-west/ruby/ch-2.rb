#! /usr/bin/ruby

def digitcountvalue(a)
  c = Hash.new
  c.default = 0
  a.each do |n|
    c[n] += 1
  end
  0.upto(a.size - 1) do |ix|
    if a[ix] != c[ix]
      return false
    end
  end
  true
end

require 'test/unit'

class TestDigitcountvalue < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, digitcountvalue([1, 2, 1, 0]))
  end

  def test_ex2
    assert_equal(false, digitcountvalue([0, 3, 0]))
  end

end
