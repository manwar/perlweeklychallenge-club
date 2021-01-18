#! /usr/bin/ruby

def ed(s,t)
  ss=[0,s.split('')].flatten
  tt=[0,t.split('')].flatten
  d=Array.new
  1.upto(ss.length) do
    d.push([0] * tt.length)
  end
  1.upto(ss.length-1) do |i|
    d[i][0]=i
  end
  1.upto(tt.length-1) do |i|
    d[0][i]=i
  end
  1.upto(tt.length-1) do |j|
    1.upto(ss.length-1) do |i|
      sc=0
      if ss[i] != tt[j] then
        sc=1
      end
      d[i][j]=[
        d[i-1][j]+1,
        d[i][j-1]+1,
        d[i-1][j-1]+sc,
      ].min
    end
  end
  return d[ss.length-1][tt.length-1]
end

require 'test/unit'

class TestEd < Test::Unit::TestCase

  def test_ex1
    assert_equal(3,ed('kitten','sitting'))
  end

  def test_ex2
    assert_equal(2,ed('sunday','monday'))
  end

  def test_ex3
    assert_equal(1,ed('branscombe','ranscombe'))
  end

end
