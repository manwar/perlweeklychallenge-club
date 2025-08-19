#! /usr/bin/ruby

def counterify(a)
  cc = Hash.new
  cc.default = 0
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def commoncharacters(a)
  mc = Hash.new
  first = true
  a.each do |s|
    mk = counterify(s.chars)
    if first
      mc = mk
      first = false
    else
      mc.keys.each do |k|
        if mk.has_key?(k)
          mc[k] = [mc[k], mk[k]].min
        else
          mc.delete(k)
        end
      end
    end
  end
  out = []
  mc.keys.sort.each do |c|
    1.upto(mc[c]) do
      out.push(c)
    end
  end
  out
end

require 'test/unit'

class TestCommoncharacters < Test::Unit::TestCase

  def test_ex1
    assert_equal(['e', 'l', 'l'], commoncharacters(['bella', 'label', 'roller']))
  end

  def test_ex2
    assert_equal(['c', 'o'], commoncharacters(['cool', 'lock', 'cook']))
  end

  def test_ex3
    assert_equal(['l', 'o'], commoncharacters(['hello', 'world', 'pole']))
  end

  def test_ex4
    assert_equal([], commoncharacters(['abc', 'def', 'ghi']))
  end

  def test_ex5
    assert_equal(['a', 'a'], commoncharacters(['aab', 'aac', 'aaa']))
  end

end
