#! /usr/bin/ruby

require 'set'

def maximumpairs(a)
  n = 0
  r = Set.new
  a.each do |s|
    t = s.reverse
    if r.include?(t) then
      n += 1
    else
      r.add(s)
    end
  end
  return n
end

require 'test/unit'

class TestMaximumpairs < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, maximumpairs(['ab', 'de', 'ed', 'bc']))
  end

  def test_ex2
    assert_equal(0, maximumpairs(['aa', 'ba', 'cd', 'ed']))
  end

  def test_ex3
    assert_equal(2, maximumpairs(['uv', 'qp', 'st', 'vu', 'mn', 'pq']))
  end

end
