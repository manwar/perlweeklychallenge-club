#! /usr/bin/ruby

require 'test/unit'

require 'set'

def cutelist(n)
  tab = [[false]]
  1.upto(n) do
    tab.push([false] * (n+1))
  end
  1.upto(n) do |x|
    1.upto(x) do |y|
      if x % y != 0 && y % x != 0 then
        tab[x][y] = true
        tab[y][x] = true
      end
    end
  end
  count = 0
  stackl = [[]]
  stackc = [(1..n).to_a]
  while stackl.length > 0 do
    l = stackl.pop
    c = stackc.pop
    if c.length == 0 && l.length == n then
      count += 1
    else
      place = l.length + 1
      c.each do |candidate|
        if !tab[place][candidate] then
          q = l[0..-1]
          q.push(candidate)
          stackl.push(q)
          stackc.push(c.reject {|i| i == candidate})
        end
      end
    end
  end
  return count
end

class TestCutelist < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, cutelist(2));
  end

  def test_ex2
    assert_equal(700, cutelist(10));
  end

  def test_ex3
    assert_equal(24679, cutelist(15));
  end
end
