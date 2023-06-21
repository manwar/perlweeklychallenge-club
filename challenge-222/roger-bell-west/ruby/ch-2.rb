#! /usr/bin/ruby

def lastmember(a0)
  a = a0
  while a.length > 1
    a.sort!
    x = a.pop
    y = a.pop
    if x != y then
      a.push(x - y)
    end
  end
  if a.length == 0 then
    return 0
  else
    return a[0]
  end
end

require 'test/unit'

class TestLastmember < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, lastmember([2, 7, 4, 1, 8, 1]))
  end

  def test_ex2
    assert_equal(1, lastmember([1]))
  end

  def test_ex3
    assert_equal(0, lastmember([1, 1]))
  end

end
