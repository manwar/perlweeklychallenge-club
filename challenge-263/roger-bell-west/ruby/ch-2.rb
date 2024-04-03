#! /usr/bin/ruby

def mergeitems(a, b)
  c = Hash.new(0)
  [a, b] .each do |v|
    v.each do |w|
      c[w[0]] += w[1]
    end
  end
  return c.keys.sort.map {|i| [i, c[i]]}
end

require 'test/unit'

class TestMergeitems < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1, 4], [2, 3], [3, 2]], mergeitems([[1, 1], [2, 1], [3, 2]], [[2, 2], [1, 3]]))
  end

  def test_ex2
    assert_equal([[1, 8], [2, 3], [3, 3]], mergeitems([[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]]))
  end

  def test_ex3
    assert_equal([[1, 1], [2, 9], [3, 3]], mergeitems([[1, 1], [2, 2], [3, 3]], [[2, 3], [2, 4]]))
  end

end
