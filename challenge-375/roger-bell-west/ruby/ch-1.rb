#! /usr/bin/ruby

def counterify(a)
  cc = Hash.new
  cc.default = 0
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def singlecommonword(a, b)
  ac = counterify(a)
  bc = counterify(b)
  total = 0
  ac.each do |(w, ca)|
    if ca == 1 && bc.has_key?(w) && bc[w] == 1
      total += 1
    end
  end
  total
end

require 'test/unit'

class TestSinglecommonword < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, singlecommonword(['apple', 'banana', 'cherry'], ['banana', 'cherry', 'date']))
  end

  def test_ex2
    assert_equal(2, singlecommonword(['a', 'ab', 'abc'], ['a', 'a', 'ab', 'abc']))
  end

  def test_ex3
    assert_equal(0, singlecommonword(['orange', 'lemon'], ['grape', 'melon']))
  end

  def test_ex4
    assert_equal(0, singlecommonword(['test', 'test', 'demo'], ['test', 'demo', 'demo']))
  end

  def test_ex5
    assert_equal(1, singlecommonword(['Hello', 'world'], ['hello', 'world']))
  end

end
