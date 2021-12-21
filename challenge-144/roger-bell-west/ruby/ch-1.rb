#! /usr/bin/ruby

require 'set'

def semiprime(mx)
  mxx=(mx/2).to_i
  primesh=Set.new(2..mxx)
  p=2
  while p*p <= mxx do
    if primesh.include?(p)
      (p*p..mxx).step(p) do |i|
        primesh.delete?(i)
      end
    end
    if p==2 then
      p -= 1
    end
    p += 2
  end
  primes=primesh.each.sort
  semiprimesh=Set.new
  0.upto(primes.length()-1) do |i|
    i.upto(primes.length()-1) do |j|
      t=primes[i]*primes[j]
      if t <= mx then
        semiprimesh.add(t)
      else
        break
      end
    end
  end
  return semiprimesh.each.sort
end

require 'test/unit'

class TestSemiprime < Test::Unit::TestCase

  def test_ex1
    assert_equal([4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, 39, 46, 49, 51, 55, 57, 58, 62, 65, 69, 74, 77, 82, 85, 86, 87, 91, 93, 94, 95],semiprime(100))
  end

end
