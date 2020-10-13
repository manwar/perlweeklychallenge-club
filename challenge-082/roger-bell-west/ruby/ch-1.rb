#! /usr/bin/ruby

require 'set'

def factor(n)
  o=Set.new([1,n])
  2.upto(Math.sqrt(n).floor) do |i|
    if (n % i == 0)
      o.add(n/i)
      o.add(i)
    end
  end
  return o
end

def commonfactor(*fs)
  f=fs.map{|x| factor(x)}
  s=f.pop
  while (!f.empty?)
    s = s & f.pop
  end
  return s.sort
end

require 'test/unit'

class TestCf < Test::Unit::TestCase

  def test_f1
    assert_equal(Set.new([1,2,3,4,6,12]),factor(12))
  end

  def test_f2
    assert_equal(Set.new([1,2,3,6,9,18]),factor(18))
  end

  def test_f3
    assert_equal(Set.new([1,23]),factor(23))
  end

  def test_cf1
    assert_equal([1,2,3,6],commonfactor(12,18))
  end

  def test_cf2
    assert_equal([1],commonfactor(18,23))
  end

end
