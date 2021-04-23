#! /usr/bin/ruby

$cache=Hash.new

def fusc(n)
  if $cache.has_key?(n) then
    return $cache[n]
  end
  if n==0 then
    m=0
  elsif n==1 then
    m=1
  elsif n%2==0 then
    m=fusc(n/2)
  else
    h=(n-1)/2
    m=fusc(h)+fusc(h+1)
  end
  $cache[n]=m
  return m
end

def fuscseq(m)
    return 0.upto(m-1).map{|i| fusc(i)}
end

require 'test/unit'

class TestFusc < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, 1, 5, 4, 7, 3, 8, 5, 7, 2, 7, 5, 8, 3, 7, 4, 5, 1, 6, 5, 9, 4, 11, 7, 10, 3, 11, 8, 13, 5, 12, 7, 9, 2, 9],fuscseq(50))
  end

end
