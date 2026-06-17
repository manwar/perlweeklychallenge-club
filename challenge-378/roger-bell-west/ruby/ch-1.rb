#! /usr/bin/ruby

require 'set'

def secondlargestdigit(a)
  p = a.chars.select { |x| x >= '0' && x <= '9' }.to_set
  k = p.to_a.sort.reverse
  if k.size > 1
    k[1].to_i
  else
    -1
  end
end

require 'test/unit'

class TestSecondlargestdigit < Test::Unit::TestCase

  def test_ex1
    assert_equal(-1, secondlargestdigit('aaaaa77777'))
  end

  def test_ex2
    assert_equal(-1, secondlargestdigit('abcde'))
  end

  def test_ex3
    assert_equal(8, secondlargestdigit('9zero8eight7seven9'))
  end

  def test_ex4
    assert_equal(8, secondlargestdigit('xyz9876543210'))
  end

  def test_ex5
    assert_equal(4, secondlargestdigit('4abc4def2ghi8jkl2'))
  end

end
