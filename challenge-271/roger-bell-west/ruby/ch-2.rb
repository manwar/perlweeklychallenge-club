#! /usr/bin/ruby

require "set"

def popcount(x0)
  x = x0
  c = 0
  while x > 0 do
    x &= x - 1
    c += 1
  end
  return c
end

def sortbyonebits(a)
  c = Hash.new
  Set.new(a).each do |n|
    c[n] = popcount(n)
  end
  return a.sort do |aa, bb|
    if c[aa] == c[bb] then
      aa <=> bb
    else
      c[aa] <=> c[bb]
    end
  end
end

require 'test/unit'

class TestSortbyonebits < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 1, 2, 4, 8, 3, 5, 6, 7], sortbyonebits([0, 1, 2, 3, 4, 5, 6, 7, 8]))
  end

  def test_ex2
    assert_equal([64, 128, 256, 512, 1024], sortbyonebits([1024, 512, 256, 128, 64]))
  end

end
