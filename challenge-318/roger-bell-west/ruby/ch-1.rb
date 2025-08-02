#! /usr/bin/ruby

def groupposition(a)
  mx = []
  lc = "z"
  a.chars.each_with_index do |c, i|
    if i == 0
      lc = (c.ord + 1).chr
    end
    if lc == c
      mc = mx.length
      mx[mc - 1][1] += 1
    else
      mx.push([c, 1])
      lc = c
    end
  end
  out = []
  mx.each do |ms|
    if ms[1] >= 3
      out.push(ms[0] * ms[1])
    end
  end
  out
end

require 'test/unit'

class TestGroupposition < Test::Unit::TestCase

  def test_ex1
    assert_equal(['cccc'], groupposition('abccccd'))
  end

  def test_ex2
    assert_equal(['aaa', 'dddd', 'fff'], groupposition('aaabcddddeefff'))
  end

  def test_ex3
    assert_equal([], groupposition('abcdd'))
  end

end
