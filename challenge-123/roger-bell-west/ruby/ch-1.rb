#! /usr/bin/ruby

def un(m)
  n=0
  s=[[1],[1],[1]]
  c=[2,3,5]
  1.upto(m) do
    n=[s[0][0],s[1][0],s[2][0]].min
    0.upto(2) do |i|
      if s[i][0]==n then
        s[i].shift
      end
      s[i].push(n*c[i])
    end
  end
  return n
end

require 'test/unit'

class TestUn < Test::Unit::TestCase

  def test_ex1
    assert_equal(8,un(7))
  end

  def test_ex2
    assert_equal(12,un(10))
  end

  def test_ex3
    assert_equal(16200,un(200))
  end
  
end
