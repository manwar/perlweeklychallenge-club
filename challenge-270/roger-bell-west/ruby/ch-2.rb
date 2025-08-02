#! /usr/bin/ruby

class Op
  attr_accessor :a
  attr_accessor :cost
  def initialize(a, cost)
    @a = a
    @cost = cost
  end
end

def equalizearray(a0, x, y)
  a = a0.sort
  limit = a[-1]
  queue = Array.new
  queue.push(Op.new(a, 0))
  mc = nil
  while queue.size > 0
    op = queue.shift
    if !mc || mc > op.cost
      if op.a[0] == op.a[-1]
        mc = op.cost
      else
        p = op.a.dup
        p[0] += 1
        if p[0] <= limit
          p = p.sort
          queue.push(Op.new(p, op.cost + x))
          q = op.a.dup
          q[0] += 1
          q[1] += 1
          if q[1] <= limit
            q = q.sort
            queue.push(Op.new(q, op.cost + y))
          end
        end
      end
    end
  end
  return mc
end

require 'test/unit'

class TestEqualizearray < Test::Unit::TestCase

  def test_ex1
    assert_equal(9, equalizearray([4, 1], 3, 2))
  end

  def test_ex2
    assert_equal(6, equalizearray([2, 3, 3, 3, 5], 2, 1))
  end

end
