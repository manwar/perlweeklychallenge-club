#! /usr/bin/ruby

require 'test/unit'

def maxgap(l0)
  if l0.length < 2 then
    return 0
  end
  l = l0.sort
  q = []
  l.each_cons(2) do |i|
    q.push(i[1] - i[0])
  end
  mq = q.max
  return q.count {|i| i == mq}
end

class TestMaxgap < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, maxgap([2, 5, 8, 1]))
  end

  def test_ex2
    assert_equal(0, maxgap([3]))
  end

end
