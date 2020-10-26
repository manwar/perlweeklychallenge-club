#! /usr/bin/ruby

def fa(*a)
  ss=a.sum
  ls=ss
  li=0
  1.upto(a.length) do |inv|
    a.combination(inv) do |l|
      s=ss-2*l.sum
      if s >= 0
        if (ls == ss or s < ls or (s == ls and inv < li))
          ls=s
          li=inv
        end
      end
    end
  end
  return li
end

require 'test/unit'

class TestFa < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,fa(3,10,8))
  end

  def test_ex2
    assert_equal(1,fa(12,2,10))
  end

  def test_ex3
    assert_equal(2,fa(2,2,10))
  end

end
