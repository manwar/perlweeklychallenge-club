#! /usr/bin/ruby

def aop(*ns)
  p=ns.reduce(:*)
  return ns.map {|x| p.div(x)}
end

require 'test/unit'

class TestAop < Test::Unit::TestCase

  def test_ex1
    assert_equal([24, 60, 120, 30, 40],aop(5, 2, 1, 4, 3))
  end

  def test_ex2
    assert_equal([12, 24, 6, 8],aop(2, 1, 4, 3))
  end

end
