#! /usr/bin/ruby

def maxwords(a)
  a.map { |x| x.split(' ').length }.max
end

require 'test/unit'

class TestMaxwords < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, maxwords(['Hello world', 'This is a test', 'Perl is great']))
  end

  def test_ex2
    assert_equal(1, maxwords(['Single']))
  end

  def test_ex3
    assert_equal(7, maxwords(['Short', 'This sentence has six words in total', 'A B C', 'Just four words here']))
  end

  def test_ex4
    assert_equal(3, maxwords(['One', 'Two parts', 'Three part phrase', '']))
  end

  def test_ex5
    assert_equal(10, maxwords(['The quick brown fox jumps over the lazy dog', 'A', 'She sells seashells by the seashore', 'To be or not to be that is the question']))
  end

end
