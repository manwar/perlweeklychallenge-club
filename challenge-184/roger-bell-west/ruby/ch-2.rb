#! /usr/bin/ruby

require 'test/unit'

def splitarray(list)
  out = [ [], [] ]
  list.each do |ins|
    av = []
    bv = []
    ins.chars do |c|
      if c >= '0' && c <= '9' then
        av.push(c.to_i)
      elsif c >= 'a' && c <= 'z' then
        bv.push(c)
      end
    end
    if av.length > 0 then
      out[0].push(av)
    end
    if bv.length > 0 then
      out[1].push(bv)
    end
  end
  return out
end

class TestSplitarray < Test::Unit::TestCase

  def test_ex1
    assert_equal([ [[1, 2, 0], [3, 4]],
                   [['a', 'b'], ['c', 'd']] ],
                 splitarray(["a 1 2 b 0", "3 c 4 d"]))
  end

  def test_ex2
    assert_equal([ [[1, 2], [3], [4, 5]],
                   [['p', 'q', 'r'], ['s'], ['t']] ],
                 splitarray(["1 2", "p q r", "s 3", "4 5 t"]))
  end

end
