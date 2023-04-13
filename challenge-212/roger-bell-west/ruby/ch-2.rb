#! /usr/bin/ruby

require 'test/unit'

def rearrangegroups(list, size)
  h = Hash.new
  list.each do |k|
    if h.has_key?(k) then
      h[k] += 1
    else
      h[k] = 1
    end
  end
  out = []
  while true do
    m = h.keys.min
    res = (m .. m + size - 1).to_a
    res.each do |n|
      if h.has_key?(n) then
        p = h[n] - 1
        if p == 0 then
          h.delete(n)
        else
          h[n] = p
        end
      else
        return []
      end
    end
    out.push(res)
    if h.length == 0 then
      break
    end
  end
  return out
end

class TestRearrangegroups < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1, 2, 3], [1, 2, 3], [5, 6, 7]], rearrangegroups([1, 2, 3, 5, 1, 2, 7, 6, 3], 3))
  end

  def test_ex2
    assert_equal([], rearrangegroups([1, 2, 3], 2))
  end

  def test_ex3
    assert_equal([], rearrangegroups([1, 5, 2, 6, 4, 7], 3))
  end

end
