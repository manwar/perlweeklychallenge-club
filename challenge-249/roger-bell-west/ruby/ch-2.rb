#! /usr/bin/ruby

def distringmatch(a)
  v = 1 << (a.length - 1)
  wv = v << 1
  out = [wv]
  a.chars do |c|
    if c == "I" then
      wv += v
    else
      wv -= v
    end
    v >>= 1
    out.push(wv)
  end
  c = Hash.new
  out.sort.each_with_index do |v, i|
    c[v] = i
  end
  return out.collect { |v| c[v] }
end

require 'test/unit'

class TestDistringmatch < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 4, 1, 3, 2], distringmatch('IDID'))
  end

  def test_ex2
    assert_equal([0, 1, 2, 3], distringmatch('III'))
  end

  def test_ex3
    assert_equal([3, 2, 0, 1], distringmatch('DDI'))
  end

end
