#! /usr/bin/ruby

require 'set'

def uniquefractiongenerator(a)
  den = 1
  2.upto(a) do |dn|
    den *= dn
  end
  f = Set.new
  1.upto(a) do |d|
    nd = den.div(d)
    1.upto(a) do |n|
      f.add(n * nd)
    end
  end
  out = []
  f.sort.each do |n|
    g = n.gcd(den)
    nn = n.div(g)
    nd = den.div(g)
    out.push(sprintf("%s/%s", nn, nd))
  end
  out
end


require 'test/unit'

class TestUniquefractiongenerator < Test::Unit::TestCase

  def test_ex1
    assert_equal(['1/3', '1/2', '2/3', '1/1', '3/2', '2/1', '3/1'], uniquefractiongenerator(3))
  end

  def test_ex2
    assert_equal(['1/4', '1/3', '1/2', '2/3', '3/4', '1/1', '4/3', '3/2', '2/1', '3/1', '4/1'], uniquefractiongenerator(4))
  end

  def test_ex3
    assert_equal(['1/1'], uniquefractiongenerator(1))
  end

  def test_ex4
    assert_equal(['1/6', '1/5', '1/4', '1/3', '2/5', '1/2', '3/5', '2/3', '3/4', '4/5', '5/6', '1/1', '6/5', '5/4', '4/3', '3/2', '5/3', '2/1', '5/2', '3/1', '4/1', '5/1', '6/1'], uniquefractiongenerator(6))
  end

  def test_ex5
    assert_equal(['1/5', '1/4', '1/3', '2/5', '1/2', '3/5', '2/3', '3/4', '4/5', '1/1', '5/4', '4/3', '3/2', '5/3', '2/1', '5/2', '3/1', '4/1', '5/1'], uniquefractiongenerator(5))
  end

end
