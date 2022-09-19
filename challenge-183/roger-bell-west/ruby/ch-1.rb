#! /usr/bin/ruby

require 'test/unit'

require 'set'

def uniquearray(n)
  o = []
  oh = Set.new
  n.each do |i|
    ti = Marshal.dump(i)
    if (!oh.include?(ti)) then
      o.push(i)
      oh.add(ti)
    end
  end
  return o
end

class TestUniquearray < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1,2], [3,4], [5,6]],
                 uniquearray([[1,2], [3,4], [5,6], [1,2]]))
  end

  def test_ex2
    assert_equal([[9,1], [3,7], [2,5]],
                 uniquearray([[9,1], [3,7], [2,5], [2,5]]))
  end

end
