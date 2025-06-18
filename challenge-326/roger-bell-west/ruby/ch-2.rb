#! /usr/bin/ruby

def decompressedlist(a)
  out = []
  a.each_slice(2) do |n|
    out.concat(Array.new(n[0], n[1]))
  end
  out
end

require 'test/unit'

class TestDecompressedlist < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 4, 4], decompressedlist([1, 3, 2, 4]))
  end

  def test_ex2
    assert_equal([1, 2, 2], decompressedlist([1, 1, 2, 2]))
  end

  def test_ex3
    assert_equal([1, 1, 1, 2, 2, 2], decompressedlist([3, 1, 3, 2]))
  end

end
