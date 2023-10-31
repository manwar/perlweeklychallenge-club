#! /usr/bin/ruby

require 'set'
require 'prime'

def primefactorcount(n)
  return n.prime_division.collect {|i| i[1]}.sum
end

def primeorder(ints)
  c = Hash.new
  Set.new(ints).each do |n|
    c[n] = primefactorcount(n)
  end
  return ints.sort do |aa, bb|
    if c[aa] == c[bb] then
      aa <=> bb
    else
      c[aa] <=> c[bb]
    end
  end
end

require 'test/unit'

class TestPrimeorder < Test::Unit::TestCase

  def test_ex1
    assert_equal([11, 4, 8, 27], primeorder([11, 8, 27, 4]))
  end

end
