#! /usr/bin/ruby

def countprefixes(a, b)
  a.select {|x| b.start_with?(x)}.size
end

require 'test/unit'

class TestCountprefixes < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, countprefixes(['a', 'ap', 'app', 'apple', 'banana'], 'apple'))
  end

  def test_ex2
    assert_equal(0, countprefixes(['cat', 'dog', 'fish'], 'bird'))
  end

  def test_ex3
    assert_equal(4, countprefixes(['hello', 'he', 'hell', 'heaven', 'he'], 'hello'))
  end

  def test_ex4
    assert_equal(3, countprefixes(['', 'code', 'coding', 'cod'], 'coding'))
  end

  def test_ex5
    assert_equal(7, countprefixes(['p', 'pr', 'pro', 'prog', 'progr', 'progra', 'program'], 'program'))
  end

end
