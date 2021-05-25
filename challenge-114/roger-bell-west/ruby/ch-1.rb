#! /usr/bin/ruby

def npn(n)
  nn=n.to_s
  ii=""
  mm=0
  l=nn.length
  if l % 2 == 0 then
    ii=nn[0..l/2-1]
    m=1
  else
    ii=nn[0..(l+1)/2-1]
    m=0
  end
  i=ii.to_i-1
  pn=0
  while pn <= n
    ii=i.to_s
    f=ii.length
    i+=1
    if i.to_s.length > f then
      if m==0 then
        m=1
        i=10**(f-1)
      else
        m=0
        i=10**f
      end
    end
    ii=i.to_s
    k=ii.reverse
    if m==0
      pns=ii + k[1..-1]
    else
      pns=ii + k
    end
    pn=pns.to_i
  end
  return pn
end

require 'test/unit'

class TestNpn < Test::Unit::TestCase

  def test_ex1
    assert_equal(1331,npn(1234))
  end
  
  def test_ex2
    assert_equal(1001,npn(999))
  end
  
end
