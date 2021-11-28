#! /usr/bin/ruby

def cvradix(n,r,tf)
  o=0
  nn=n
  m=1
  if tf==0 then
    ra=r
    rb=10
  else
    ra=10
    rb=r
  end
  while nn>0
    nn,x=nn.divmod(ra)
    o+=x*m
    m*=rb
  end
  return o
end

def dcbadd(a,b)
  return cvradix(cvradix(a,2,1)+cvradix(b,2,1),2,0)
end

require 'test/unit'

class TestDcbadd < Test::Unit::TestCase

  def test_ex1
    assert_equal(100,dcbadd(11,1))
  end

  def test_ex2
    assert_equal(110,dcbadd(101,1))
  end

  def test_ex3
    assert_equal(111,dcbadd(100,11))
  end

end
