#! /usr/bin/ruby

def decodexor(a, init)
  out = [ init ]
  a.each do |v|
    out.push(out[-1] ^ v)
  end
  out
end

require 'test/unit'

class TestDecodexor < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 0, 2, 1], decodexor([1, 2, 3], 1))
  end

  def test_ex2
    assert_equal([4, 2, 0, 7, 4], decodexor([6, 2, 7, 3], 4))
  end

end
