#! /usr/bin/ruby

require 'test/unit'

def widestvalley(a)
  av = []
  ac = []
  l = -1
  a.each do |v|
    if v == l then
      ac[-1] += 1
    else
      av.push(v)
      ac.push(1)
      l = v
    end
  end
  s = []
  e = []
  c = 0
  0.upto(av.length - 1) do |i|
    if i ==0 ||
       i == av.length - 1 ||
       (av[i - 1] < av[i] && av[i] > av[i + 1]) then
      s.push(c)
      e.push(c + ac[i] - 1)
    end
    c += ac[i]
  end
  out = []
  0.upto(s.length - 2) do |i|
    if e[i+1] - s[i] + 1 > out.length then
      out = a[s[i] .. e[i+1]];
    end
  end
  return out
end

class TestWidestvalley < Test::Unit::TestCase

  def test_ex1
    assert_equal([5, 5, 2, 8], widestvalley([1, 5, 5, 2, 8]))
  end

  def test_ex2
    assert_equal([2, 6, 8], widestvalley([2, 6, 8, 5]))
  end

  def test_ex3
    assert_equal([13, 13, 2, 2, 15, 17], widestvalley([9, 8, 13, 13, 2, 2, 15, 17]))
  end

  def test_ex4
    assert_equal([2, 1, 2], widestvalley([2, 1, 2, 1, 3]))
  end

  def test_ex5
    assert_equal([3, 3, 2, 1, 2, 3, 3], widestvalley([1, 3, 3, 2, 1, 2, 3, 3, 2]))
  end

end
