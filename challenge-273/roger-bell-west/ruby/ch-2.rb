#! /usr/bin/ruby

def baftera(a)
  firstb = a.index('b')
  if firstb.nil?
    return false
  end
  lasta = a.rindex('a')
  if lasta.nil?
    return true
  end
  lasta < firstb
end

require 'test/unit'

class TestBaftera < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, baftera('aabb'))
  end

  def test_ex2
    assert_equal(false, baftera('abab'))
  end

  def test_ex3
    assert_equal(false, baftera('aaa'))
  end

  def test_ex4
    assert_equal(true, baftera('bbb'))
  end

end
