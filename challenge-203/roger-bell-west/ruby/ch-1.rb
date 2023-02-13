#! /usr/bin/ruby

require 'test/unit'

def specialquads(l)
  ct = 0
  l.combination(4) do |c|
    if c[0] + c[1] + c[2] == c[3] then
      ct += 1
    end
  end
  return ct
end

class TestSpecialquads < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, specialquads([1, 2, 3, 6]))
  end

  def test_ex2
    assert_equal(4, specialquads([1, 1, 1, 3, 5]))
  end

  def test_ex3
    assert_equal(0, specialquads([3, 3, 6, 4, 5]))
  end

end
