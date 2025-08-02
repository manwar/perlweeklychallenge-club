#! /usr/bin/crystal

struct Op
  property a, cost

  def initialize(@a : Array(Int32), @cost : Int32)
  end
end

def equalizearray(a0 : Array(Int32), x : Int32, y : Int32) : Int32?
  a = a0.sort
  limit = a[-1]
  queue = Deque(Op).new
  queue.push(Op.new(a, 0))
  mc : Int32 | Nil = nil
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
  mc
end

require "spec"
describe "#tmpl_var name=function>" do
  it "test_ex1" do
    equalizearray([4, 1], 3, 2).should eq 9
  end
  it "test_ex2" do
    equalizearray([2, 3, 3, 3, 5], 2, 1).should eq 6
  end
end
