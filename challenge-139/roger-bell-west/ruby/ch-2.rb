#! /usr/bin/ruby

def is_prime(n)
  if n>2 && n%2==0 then
    return 0
  end
  if n>3 && n%3==0 then
    return 0
  end
  lim=Integer.sqrt(n)
  k6=0
  while 1
    k6+=6
    [k6-1,k6+1].each do |t|
      if t<=lim then
        if n%t == 0 then
          return false
        end
      else
        return true
      end
    end
  end
end

def longprime(n)
  nn=n
  o=[]
  ba=[7]
  k6=6
  while nn>0
    if ba.length==0 then
      k6+=6
      ba=[k6+1,k6-1]
    end
    b=ba.pop
    if is_prime(b) then
      k=1
      l=0
      while 1
        k*=10
        l+=1
        k%=b
        if k==1 then
          break
        end
      end
      if l==b-1 then
        o.push(b)
        nn-=1
      end
    end
  end
  return o
end

require 'test/unit'

class TestLongprime < Test::Unit::TestCase

  def test_ex1
    assert_equal([7, 17, 19, 23, 29],longprime(5))
  end

  def test_ex2
    assert_equal([7, 17, 19, 23, 29, 47, 59, 61, 97, 109, 113, 131, 149, 167, 179, 181, 193, 223, 229, 233, 257, 263, 269, 313, 337, 367, 379, 383, 389, 419, 433, 461, 487, 491, 499, 503, 509, 541, 571, 577, 593, 619, 647, 659, 701, 709, 727, 743, 811, 821, 823, 857, 863, 887, 937, 941, 953, 971, 977, 983],longprime(60))
  end

end
