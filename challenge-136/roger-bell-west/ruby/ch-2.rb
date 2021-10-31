#! /usr/bin/ruby

def fibseq(m)
  return f(m,1,1)
end

def f(x,y,z)
  if x<y then
    return (x==0)?1:0
  else
    return f(x-y,y+z,y)+f(x,y+z,y)
  end
end

require 'test/unit'

class TestFibseq < Test::Unit::TestCase

  def test_ex1
    assert_equal(4,fibseq(16))
  end

  def test_ex2
    assert_equal(2,fibseq(9))
  end

  def test_ex3
    assert_equal(2,fibseq(15))
  end

end
