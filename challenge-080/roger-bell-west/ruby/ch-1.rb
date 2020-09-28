#! /usr/bin/ruby

def spn(list)
  r=Hash.new
  for x in list
    if x > 0
      r[x]=1
    end
  end
  m=1
  while r.has_key?(m)
    m += 1
  end
  return m
end

require 'test/unit'

class TestSpn < Test::Unit::TestCase

  def test_1
    assert_equal(1,spn([5,2,-2,0]))
  end

  def test_2
    assert_equal(2,spn([1,8,-1]))
  end

  def test_3
    assert_equal(1,spn([2,0,-1]))
  end

end
