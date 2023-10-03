#! /usr/bin/ruby

def maximisegreatness(a)
  b = a.sort
  g = 0
  b.each do |c|
    if c > b[g] then
      g += 1
    end
  end
  return g
end

require 'test/unit'

class TestMaximisegreatness < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, maximisegreatness([1, 3, 5, 2, 1, 3, 1]))
  end

  def test_ex2
    assert_equal(3, maximisegreatness([1, 2, 3, 4]))
  end

end
