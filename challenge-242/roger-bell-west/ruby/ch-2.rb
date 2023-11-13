#! /usr/bin/ruby

def flipmatrix(a)
  return a.collect{|r| r.collect{|m| 1-m}.reverse}
end

require 'test/unit'

class TestFlipmatrix < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1, 0, 0], [0, 1, 0], [1, 1, 1]], flipmatrix([[1, 1, 0], [1, 0, 1], [0, 0, 0]]))
  end

  def test_ex2
    assert_equal([[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]], flipmatrix([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]))
  end

end
