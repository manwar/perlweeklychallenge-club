#! /usr/bin/ruby

def ri(n,d)
  dd=Regexp.new(d.to_s)
  e=1.upto(n).find_all {|i| i.to_s =~ dd}
  1.upto(1<<e.length()-1) { |i|
    s=0
    0.upto(e.length()-1) { |ii|
      if 1<<ii & i then
        s += e[ii]
      end
    }
    if s==n then
      return 1
    end
  }
  return 0
end

require 'test/unit'

class TestRi < Test::Unit::TestCase

  def test_ex1
    assert_equal(0,ri(25,7))
  end
  
  def test_ex2
    assert_equal(1,ri(24,7))
  end
  
end
