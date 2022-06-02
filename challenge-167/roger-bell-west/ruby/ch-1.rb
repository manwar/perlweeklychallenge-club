#! /usr/bin/ruby

require 'test/unit'

require 'set'
require 'prime'

def cyclicpermute(n)
  ss = n.to_s
  o = []
  1.upto(ss.length) do
    ss = ss[1..-1] + ss[0]
    o.push(ss.to_i)
  end
  return o
end

def circular(mindigits, ct)
  o = []
  base = 1
  2.upto(mindigits) do
    base *= 10
  end
  while o.length < ct do
    pmax = base * 10
    pr = []
    Prime.each do |p|
      if p >= base then
        if p > pmax then
          break
        end
        pr.push(p)
      end
    end
    prs = Set.new(pr)
    pr.each do |cp|
      v = true
      cpp = cyclicpermute(cp)
      cpp.each do |cpc|
        if !prs.include?(cpc) then
          v = false
          break
        end
      end
      if v then
        o.push(cp)
        if o.length >= ct then
          break
        end
        cpp.each do |cpc|
          prs.delete(cpc)
        end
      end
    end
    base *= 10
  end
  return o
end

class TestCircular < Test::Unit::TestCase

  def test_ex1
    assert_equal([231, 312, 123],cyclicpermute(123))
  end

  def test_ex2
    assert_equal([113, 197, 199, 337, 1193, 3779, 11939, 19937,
                  193939, 199933],circular(3,10))
  end

end
