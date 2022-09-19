#! /usr/bin/ruby

require 'test/unit'

def firstunique(s)
  cc = Hash.new(0)
  s.split('').each do |c|
    cc[c] += 1
  end
  s.split('').each_with_index do |c, i|
    if cc[c] == 1 then
      return i
    end
  end
  return -1
end

class TestFirstUnique < Test::Unit::TestCase

  def test_ex1
    assert_equal(0, firstunique("Perl Weekly Challenge"))
  end

  def test_ex2
    assert_equal(1, firstunique("Long Live Perl"))
  end

  def test_ex3
    assert_equal(-1, firstunique("aabbcc"))
  end

end
