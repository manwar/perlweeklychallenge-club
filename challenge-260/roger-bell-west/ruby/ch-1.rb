#! /usr/bin/ruby

require 'set'

def uniqueoccurrences(a)
  c = Hash.new(0)
  a.each do |n|
    c[n] += 1
  end
  if c.length == Set.new(c.values).length then
    return 1
  else
    return 0
  end
end

require 'test/unit'

class TestUniqueoccurrences < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, uniqueoccurrences([1, 2, 2, 1, 1, 3]))
  end

  def test_ex2
    assert_equal(0, uniqueoccurrences([1, 2, 3]))
  end

  def test_ex3
    assert_equal(1, uniqueoccurrences([-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]))
  end

end
