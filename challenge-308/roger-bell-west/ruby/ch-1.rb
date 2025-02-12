#! /usr/bin/ruby

require 'set'

def countcommon(a, b)
  aa = Set.new(a)
  bb = Set.new(b)
  (aa & bb).length
end

require 'test/unit'

class TestCountcommon < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, countcommon(['perl', 'weekly', 'challenge'], ['raku', 'weekly', 'challenge']))
  end

  def test_ex2
    assert_equal(1, countcommon(['perl', 'raku', 'python'], ['python', 'java']))
  end

  def test_ex3
    assert_equal(0, countcommon(['guest', 'contribution'], ['fun', 'weekly', 'challenge']))
  end

end
