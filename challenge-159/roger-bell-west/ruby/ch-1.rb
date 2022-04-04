#! /usr/bin/ruby

require 'test/unit'

require 'set'
require 'prime'

def lcmseries(s)
  return s.inject {|a, b| a.lcm(b)}
end

def farey(n)
  l=lcmseries(2.upto(n))
  d={}
  s=[]
  1.upto(n) do |i|
    m = l / i
    0.upto(i) do |j|
      k = m * j
      if !d.has_key?(k) then
        d[k]=[j,i]
        s.push(k)
      end
    end
  end
  s.sort!
  return s.map{|i| d[i]}
end

class TestFarey < Test::Unit::TestCase

  def test_ex1
    assert_equal([[0, 1], [1, 5], [1, 4], [1, 3], [2, 5], [1, 2],
                  [3, 5], [2, 3], [3, 4], [4, 5], [1, 1]],
                 farey(5))
  end

  def test_ex2
    assert_equal([[0, 1], [1, 7], [1, 6], [1, 5], [1, 4], [2, 7],
                  [1, 3], [2, 5], [3, 7], [1, 2], [4, 7], [3, 5],
                  [2, 3], [5, 7], [3, 4], [4, 5], [5, 6], [6, 7],
                  [1, 1]],
                 farey(7))
  end

  def test_ex3
    assert_equal([[0, 1], [1, 4], [1, 3], [1, 2], [2, 3], [3, 4],
                  [1, 1]],
                 farey(4))
  end

end
