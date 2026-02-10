#! /usr/bin/ruby

def wordsorter(a)
  w = a.split
  w.sort_by! { |w| w.downcase }
  w.join(" ")
end

require 'test/unit'

class TestWordsorter < Test::Unit::TestCase

  def test_ex1
    assert_equal('brown fox quick The', wordsorter('The quick brown fox'))
  end

  def test_ex2
    assert_equal('are Hello How World! you?', wordsorter('Hello    World!   How   are you?'))
  end

  def test_ex3
    assert_equal('Hello', wordsorter('Hello'))
  end

  def test_ex4
    assert_equal('are Hello, How World! you?', wordsorter('Hello, World! How are you?'))
  end

  def test_ex5
    assert_equal('2 3 and apples bananas! have I', wordsorter('I have 2 apples and 3 bananas!'))
  end

end
