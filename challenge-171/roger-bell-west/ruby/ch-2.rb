#! /usr/bin/ruby

require 'test/unit'

def compose(f1,f2)
  return lambda { |x| f1.call(f2.call(x)) }
end

class TestCompose < Test::Unit::TestCase

  def test_ex1
    f = lambda { |x| return x+1 }
    g = lambda { |x| return x*2 }
    h = compose(f,g)
    1.upto(10) do |i|
      assert_equal(h.call(i),
                   f.call(g.call(i)))
    end
  end

end
