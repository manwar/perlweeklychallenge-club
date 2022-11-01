#! /usr/bin/ruby

require 'test/unit'

def greatercharacter(a, k)
  aa = a.find_all {|x| x > k}.sort()
  if aa.length > 0 then
    return aa[0]
  else
    return k
  end
end

class TestDivisiblepairs < Test::Unit::TestCase

  def test_ex1
    assert_equal('e', greatercharacter(['e', 'm', 'u', 'g'], 'b'))
  end

  def test_ex2
    assert_equal('c', greatercharacter(['d', 'c', 'e', 'f'], 'a'))
  end

  def test_ex3
    assert_equal('r', greatercharacter(['j', 'a', 'r'], 'o'))
  end

  def test_ex4
    assert_equal('c', greatercharacter(['d', 'c', 'a', 'f'], 'a'))
  end

  def test_ex5
    assert_equal('v', greatercharacter(['t', 'g', 'a', 'l'], 'v'))
  end
end
