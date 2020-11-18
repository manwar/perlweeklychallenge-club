#! /usr/bin/ruby

def lcs(*ns)
  l=ns.sort
  w=Array.new
  r=Array.new
  while (n=l.shift)
    if (w.length==0 or n==w[-1]+1)
      w.push(n)
    else
      if (w.length > r.length)
        r=w
      end
      w=[n]
    end
  end
  if (w.length > r.length)
    r=w
  end
  if (r.length > 1)
    return r
  else
    return 0
  end
end

require 'test/unit'

class TestLcs < Test::Unit::TestCase

  def test_ex1
    assert_equal([2,3,4],lcs(100, 4, 50, 3, 2))
  end

  def test_ex2
    assert_equal(0,lcs(20, 30, 10, 40, 50))
  end

  def test_ex3
    assert_equal([9,10,11],lcs(20, 19, 9, 11, 10))
  end

  def test_ex4
    assert_equal([18,19,20],lcs(20, 19, 18, 11, 10))
  end

end
