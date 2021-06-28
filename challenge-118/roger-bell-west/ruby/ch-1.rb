#! /usr/bin/ruby

def bp(n)
  s=sprintf('%b',n)
  l=s.length-1
  0.upto((l/2).to_i) do |i|
    if s[i] != s[l-i] then
      return 0
    end
  end
  return 1
end

require 'test/unit'

class TestBp < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,bp(5))
  end
  
  def test_ex2
    assert_equal(0,bp(4))
  end
  
end
