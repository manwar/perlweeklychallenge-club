#! /usr/bin/ruby

def lastword(a)
  w = a.split(" ").select{|x| x.size > 0}
  w[w.size - 1].size
end

require 'test/unit'

class TestLastword < Test::Unit::TestCase

  def test_ex1
    assert_equal(9, lastword('The Weekly Challenge'))
  end

  def test_ex2
    assert_equal(5, lastword('   Hello   World    '))
  end

  def test_ex3
    assert_equal(3, lastword("Let's begin the fun"))
  end

end
