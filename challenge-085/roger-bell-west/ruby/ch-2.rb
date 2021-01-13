#! /usr/bin/ruby

def pti(n)
  l=Math.log(n)
  2.upto(Math.sqrt(n).floor) do |ca|
    bg=(l/Math.log(ca)).floor
    bg.upto(bg+1) do |cb|
      if ca ** cb == n
        return 1
      end
    end
  end
  return 0
end

require 'test/unit'

class TestPti < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,pti(8))
  end

  def test_ex2
    assert_equal(0,pti(15))
  end

  def test_ex3
    assert_equal(1,pti(125))
  end

end
