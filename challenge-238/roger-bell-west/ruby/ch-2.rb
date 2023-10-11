#! /usr/bin/ruby

require 'set'

def persistence(a)
  steps = 0
  b = a
  while b > 9 do
    steps += 1
    p = 1
    while b > 0 do
      b, pm = b.divmod(10)
      p *= pm
    end
    b = p
  end
  return steps
end

def persistencearray(a)
  c = Hash.new
  Set.new(a).each do |n|
    c[n] = persistence(n)
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

class TestPersistencearray < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 15, 34, 99], persistencearray([15, 99, 1, 34]))
  end

  def test_ex2
    assert_equal([22, 33, 50, 25], persistencearray([50, 25, 33, 22]))
  end

end
