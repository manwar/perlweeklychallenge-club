#! /usr/bin/ruby

def nextpermutation(a)
  b = a.sort
  flag = false
  out = []
  b.permutation do |px|
    if out.length == 0
      out = px
    end
    if flag
      out= px
      break
    end
    if px == a
      flag = true
    end
  end
  out
end

require 'test/unit'

class TestNextpermutation < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 3, 2], nextpermutation([1, 2, 3]))
  end

  def test_ex2
    assert_equal([2, 3, 1], nextpermutation([2, 1, 3]))
  end

  def test_ex3
    assert_equal([3, 2, 1], nextpermutation([3, 1, 2]))
  end

end
