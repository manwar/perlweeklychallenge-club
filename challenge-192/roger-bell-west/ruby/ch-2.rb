#! /usr/bin/ruby

require 'test/unit'

def equaldistribution(list)
  s = list.sum
  if s % list.length != 0 then
    return -1
  end
  m = s / list.length
  out = 0
  w = list
  while true do
    0.upto(w.length-2) do |i|
      if w[i] > m then
        v = w[i] - m
        w[i+1] += v
        out += v
        w[i] = m
      elsif w[i] < m then
        v = [m - w[i], w[i+1]].min
        w[i+1] -= v
        out += v
        w[i] += v
      end
    end
    if w.all? {|s| s == m} then
      break
    end
  end
  return out
end

class TestEqualdistribution < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, equaldistribution([1, 0, 5]))
  end

  def test_ex2
    assert_equal(-1, equaldistribution([0, 2, 0]))
  end

  def test_ex3
    assert_equal(2, equaldistribution([0, 3, 0]))
  end
end
