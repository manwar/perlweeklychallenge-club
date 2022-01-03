#! /usr/bin/ruby

require 'set'

def genprimes(mx)
  primesh=Set.new([2,3])
  (6..mx).step(6) do |i|
    (i-1..i+1).step(2) do |j|
      if j <= mx then
        primesh.add(j)
      end
    end
  end
  q=[2,3,5,7]
  p=q.shift
  mr=Integer.sqrt(mx)
  while p <= mr do
    if primesh.include?(p)
      (p*p..mx).step(p) do |i|
        primesh.delete?(i)
      end
    end
    if q.length<2 then
      q.push(q[-1]+4)
      q.push(q[-1]+2)
    end
    p=q.shift
  end
  return primesh.each.sort
end

def nthprime(n)
  m=15
  if n >= 6 then
    m=1+n*Math.log(n*Math.log(n)).floor
  end
  primes=genprimes(m)
  return primes[n-1]
end

require 'test/unit'

class TestNthprime < Test::Unit::TestCase

  def test_ex1
    assert_equal(104743,nthprime(10001))
  end

end
