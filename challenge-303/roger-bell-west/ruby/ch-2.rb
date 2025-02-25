#! /usr/bin/ruby

def deleteandearn(a)
  ct = Hash.new
  ct.default = 0
  a.each do |x|
    ct[x] += 1
  end
  mx = 0
  stack = Array.new
  stack.push([ct, 0])
  while stack.size > 0
    c = stack.pop
    if c[0].size == 0
      mx = [mx, c[1]].max
    else
      c[0].keys.each do |d|
        cc = c[0].clone
        cc[d] -= 1
        if cc[d] == 0
          cc.delete(d)
        end
        cc.delete(d - 1)
        cc.delete(d + 1)
        stack.push([cc, c[1] + d])
      end
    end
  end
  mx  
end

require 'test/unit'

class TestDeleteandearn < Test::Unit::TestCase

  def test_ex1
    assert_equal(6, deleteandearn([3, 4, 2]))
  end

  def test_ex2
    assert_equal(9, deleteandearn([2, 2, 3, 3, 3, 4]))
  end

end
