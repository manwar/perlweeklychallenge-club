#! /usr/bin/ruby

require 'set'

def twoofthree(a)
  ct = Hash.new(0)
  a.each do |iv|
    Set.new(iv).each do |n|
      ct[n] += 1
    end
  end
  out = []
  ct.each do |k, v|
    if v >= 2 then
      out.push(k)
    end
  end
  out = out.sort()
  return out
end

require 'test/unit'

class TestTwoofthree < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 4], twoofthree([[1, 1, 2, 4], [2, 4], [4]]))
  end

  def test_ex2
    assert_equal([1, 2, 4], twoofthree([[4, 1], [2, 4], [1, 2]]))
  end

end
