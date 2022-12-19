#! /usr/bin/ruby

require 'test/unit'

def rangelist(l)
  o = []
  start = l[0]
  prev = start
  l.slice(1, l.length-1).each do |v|
    if v != prev + 1 then
      if prev > start then
        o.push([start, prev])
      end
      start = v
    end
    prev = v
  end
  if prev > start then
    o.push([start, prev])
  end
  return o
end

class TestRangeList < Test::Unit::TestCase

  def test_ex1
    assert_equal([[3, 5]], rangelist([1, 3, 4, 5, 7]))
  end

  def test_ex2
    assert_equal([[1, 3], [6, 7]], rangelist([1, 2, 3, 6, 7, 9]))
  end

  def test_ex3
    assert_equal([[0, 2], [4, 6], [8, 9]], rangelist([0, 1, 2, 4, 5, 6, 8, 9]))
  end
end
