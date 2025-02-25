#! /usr/bin/ruby

def semiorderedpermutation(a)
    en = a.size
    s = 1
    e = en - 1
    a.each_with_index do |n, i|
        if n == 1
            s = i
        end
        if n == en
            e = i
        end
    end
    r = s + (en - 1 - e)
    if s > e
        r -= 1
    end
    r
end

require 'test/unit'

class TestSemiorderedpermutation < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, semiorderedpermutation([2, 1, 4, 3]))
  end

  def test_ex2
    assert_equal(3, semiorderedpermutation([2, 4, 1, 3]))
  end

  def test_ex3
    assert_equal(0, semiorderedpermutation([1, 3, 2, 4, 5]))
  end

end
