#! /usr/bin/ruby

require 'test/unit'

def shortesttime(n)
  dl = 1440
  ni = []
  for x in n do
    ni.push(x[0..1].to_i * 60 + x[3..4].to_i)
  end
  o = []
  ni.combination(2) do |p|
    d = (p[0] - p[1]).abs
    o.push(d)
    o.push(dl - d)
  end
  return o.min
end

class TestShortesttime < Test::Unit::TestCase

  def test_ex1
    assert_equal(5, shortesttime(['00:00', '23:55', '20:00']))
  end

  def test_ex2
    assert_equal(4, shortesttime(['01:01', '00:50', '00:57']))
  end

  def test_ex3
    assert_equal(15, shortesttime(['10:10', '09:30', '09:00', '09:55']))
  end

end
