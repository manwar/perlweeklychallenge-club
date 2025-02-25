#! /usr/bin/ruby

def lastelement(a)
  b = a
  while true do
    b.sort!
    f = b.pop
    s = b.pop
    if f > s
      b.push(f - s)
    end
    if b.length == 0
      return 0
    end
    if b.length == 1
      return b[0]
    end
  end
end

require 'test/unit'

class TestLastelement < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, lastelement([3, 8, 5, 2, 9, 2]))
  end

  def test_ex2
    assert_equal(0, lastelement([3, 2, 5]))
  end

end
