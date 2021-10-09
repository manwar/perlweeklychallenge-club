#! /usr/bin/ruby

def sumofdigits(kk)
  s=0
  kk.each do |k|
    l=k
    while l>0 do
      s+=l % 10
      l=(l/10).to_int
    end
  end
  return s
end

def factor(nn)
  n=nn
  f=[]
  ft=2
  while n>1 do
    dm=n.divmod(ft)
    if dm[1] == 0 then
      f.push(ft)
      n = dm[0]
    else
      ft += 1
      if ft % 2 == 0 then
        ft += 1
      end
    end
  end
  return f
end

def smith(ccount)
  count=ccount
  o=[]
  c=1
  while 1 do
    c += 1
    ff=factor(c)
    if ff.length==1 then
      next
    end
    if sumofdigits([c]) == sumofdigits(ff) then
      o.push(c)
      count -= 1
      if count <= 0 then
        break
      end
    end
  end
  return o
end

require 'test/unit'

class TestSmith < Test::Unit::TestCase

  def test_ex1
    assert_equal([4, 22, 27, 58, 85, 94, 121, 166, 202, 265],smith(10))
  end
  
end
