#! /usr/bin/ruby

require 'test/unit'

require 'set'

def thirdhighest(l)
  v = Set.new(l).to_a.sort.reverse
  if v.length == 0 then
    return 0
  elsif v.length <= 2 then
    return v[0]
  else
    return v[2]
  end
end

class TestThirdhighest < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, thirdhighest([5, 3, 4]))
  end

  def test_ex2
    assert_equal(6, thirdhighest([5, 6]))
  end

  def test_ex3
    assert_equal(3, thirdhighest([5, 4, 4, 3]))
  end

end
