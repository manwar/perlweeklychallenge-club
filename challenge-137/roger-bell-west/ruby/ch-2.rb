#! /usr/bin/ruby

def lychrel(nn)
  n=nn
  1.upto(100) do
    m=n.to_s.reverse.to_i
    if m==n then
      return 0
    end
    n+=m
    if n>1e7 then
      break
    end
  end
  return -1
end

require 'test/unit'

class TestLychrel < Test::Unit::TestCase

  def test_ex1
    assert_equal(0,lychrel(56))
  end

  def test_ex2
    assert_equal(0,lychrel(57))
  end

  def test_ex3
    assert_equal(0,lychrel(59))
  end

  def test_ex4
    assert_equal(-1,lychrel(196))
  end

end
