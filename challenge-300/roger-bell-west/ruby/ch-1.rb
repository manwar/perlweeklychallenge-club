#! /usr/bin/ruby

def beautifularrangement(a)
  precalc = Array.new(a + 1) { Array.new(a + 1, false) }
  1.upto(a) do |i|
    i.step(to: a, by: i) do |j|
      precalc[i][j] = true
      precalc[j][i] = true
    end
  end
  ct = 0
  stack = Array.new
  stack.push((1 .. a).to_a)
  while stack.size > 0
    trail = stack.pop
    if trail.size == 1
      ct += 1
    else
      p = a - trail.size + 2
      trail.each do |i|
        if precalc[i][p]
          tt = trail.select{|x| x != i}
          stack.push(tt)
        end
      end
    end
  end
  ct
end

require 'test/unit'

class TestBeautifularrangement < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, beautifularrangement(2))
  end

  def test_ex2
    assert_equal(1, beautifularrangement(1))
  end

  def test_ex3
    assert_equal(700, beautifularrangement(10))
  end

  def test_ex4
    assert_equal(1939684, beautifularrangement(20))
  end

end
