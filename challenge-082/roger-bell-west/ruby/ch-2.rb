#! /usr/bin/ruby

def isinterleave(a,b,c)
  l=[a,b,c].map{|x| x.length}
  buf=[[0,0,0]]
  while (!buf.empty?)
    n=buf.pop
    if (n[2] >= l[2])
      return 1
    end
    if ((n[0] < l[0]) and (a[n[0]] == c[n[2]]))
      buf.push([n[0]+1,n[1],n[2]+1])
    end
    if ((n[1] < l[1]) and (b[n[1]] == c[n[2]]))
      buf.push([n[0],n[1]+1,n[2]+1])
    end
  end
  return 0
end

require 'test/unit'

class TestInterleave < Test::Unit::TestCase

  def test_ex1
    assert_equal(isinterleave('XY','X','XXY'),1)
  end

  def test_ex2
    assert_equal(isinterleave('XXY','XXZ','XXXXZY'),1)
  end

  def test_ex3
    assert_equal(isinterleave('YX','X','XXY'),0)
  end

  def test_ex4
    assert_equal(isinterleave('ACF','BDEG','ABCDEFG'),1)
  end

  def test_ex5
    assert_equal(isinterleave('ACF','BDGE','ABCDEFG'),0)
  end

end
