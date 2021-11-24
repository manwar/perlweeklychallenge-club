#! /usr/bin/ruby

def mtable(i,j,k)
  l=[]
  1.upto(i) do |ix|
    1.upto(j) do |jx|
      l.push(ix*jx)
    end
  end
  l.sort!
  return l[k-1]
end

require 'test/unit'

class TestMtable < Test::Unit::TestCase

  def test_ex1
    assert_equal(3,mtable(2,3,4))
  end

  def test_ex2
    assert_equal(4,mtable(3,3,6))
  end

end
