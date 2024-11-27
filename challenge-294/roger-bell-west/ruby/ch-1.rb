#! /usr/bin/ruby

def consecutivesequence(a)
  b = a.sort
  mxlen = 0
  here = 0
  while true do
    (here + 1).upto(b.length - 1) do |there|
      if b[there] != there - here + b[here]
        l = there - here
        if l > mxlen
          mxlen = l
        end
        here = there
        break
      end
      if there == b.length - 1
        l = there - here + 1
        if l > mxlen
          mxlen = l
        end
        here = there
        break
      end
    end
    if here >= b.length - 1
      break
    end
  end
  if mxlen < 2
    mxlen = -1
  end
  mxlen
end

require 'test/unit'

class TestConsecutivesequence < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, consecutivesequence([10, 4, 20, 1, 3, 2]))
  end

  def test_ex2
    assert_equal(9, consecutivesequence([0, 6, 1, 8, 5, 2, 4, 3, 0, 7]))
  end

  def test_ex3
    assert_equal(-1, consecutivesequence([10, 30, 20]))
  end

end
