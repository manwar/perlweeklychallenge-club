#! /usr/bin/ruby

def sw(c)
  n=0
  p=Regexp.new("([04-9]|11)")
  while c>0 do
    n+=1
    next if p.match(n.to_s)
    c-=1
  end
  return n
end

require 'test/unit'

class TestSw < Test::Unit::TestCase

  def test_ex1
    assert_equal(13,sw(5))
  end
  
  def test_ex2
    assert_equal(32,sw(10))
  end
  
  def test_ex3
    assert_equal(2223,sw(60))
  end
  
end
