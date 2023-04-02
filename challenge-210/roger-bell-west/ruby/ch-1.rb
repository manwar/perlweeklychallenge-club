#! /usr/bin/ruby

require 'test/unit'

def killandwin(a)
  return a.sum()
end

class TestKillandwin < Test::Unit::TestCase

  def test_ex1
    assert_equal(6, killandwin([2, 3, 1]))
  end

  def test_ex2
    assert_equal(11, killandwin([1, 1, 2, 2, 2, 3]))
  end

end
