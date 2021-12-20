#! /usr/bin/ruby

def ulam(u,v,count)
  ulams=[u,v]
  sieve=[]
  uc=v
  while ulams.length() < count do
    sieve.concat(Array.new(uc+ulams[-2]-sieve.length,0))
    0.upto(ulams.length-2) do |i|
      sieve[uc + ulams[i] - 1] += 1
    end
    uc.upto(sieve.length-1) do |i|
      if sieve[i]==1 then
        uc=i+1
        ulams.push(uc)
        break
      end
    end
  end
  return ulams
end

require 'test/unit'

class TestUlam < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 2, 3, 4,  6 , 8, 11, 13, 16, 18],ulam(1,2,10))
  end

  def test_ex2
    assert_equal([2, 3, 5, 7,  8,  9, 13, 14, 18, 19],ulam(2,3,10))
  end

  def test_ex3
    assert_equal([2, 5, 7, 9, 11, 12, 13, 15, 19, 23],ulam(2,5,10))
  end

end
