#! /usr/bin/ruby

require 'set'

def pti(n,a)
  ns=Set.new(n)
  n.each do |x|
    if ns.include?(x+a)
      return 1
    end
  end
  return 0
end

require 'test/unit'

class TestPti < Test::Unit::TestCase

    def test_ex1
      assert_equal(1,pti([10, 8, 12, 15, 5],7))
    end

    def test_ex2
      assert_equal(1,pti([1, 5, 2, 9, 7],6))
    end

    def test_ex3
      assert_equal(0,pti([10, 30, 20, 50, 40],15))
    end

end
