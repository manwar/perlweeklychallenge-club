#! /usr/bin/ruby

def alternatecase(a)
  uppers = a.chars.map{|c| c == c.upcase}
  queue = []
  queue.push([uppers, 0])
  while queue.size > 0
    up, ct = queue.shift
    swaps = []
    0.upto(up.size - 2) do |i|
      if up[i] == up[i + 1]
        if i > 0
          swaps.push(i - 1)
        end
        if i < up.size - 2
          swaps.push(i + 1)
        end
      end
    end
    if swaps.size == 0
      return ct
    end
    swaps.each do |sw|
      uq = up.clone
      uq[sw], uq[sw + 1] = uq[sw + 1], uq[sw]
      queue.push([uq, ct + 1])
    end
  end
  0
end

require 'test/unit'

class TestAlternatecase < Test::Unit::TestCase

  def test_ex1
    assert_equal(0, alternatecase('aAbB'))
  end

  def test_ex2
    assert_equal(1, alternatecase('AAbb'))
  end

  def test_ex3
    assert_equal(3, alternatecase('AAAbbb'))
  end

  def test_ex4
    assert_equal(1, alternatecase('aABb'))
  end

  def test_ex5
    assert_equal(2, alternatecase('bBBAaa'))
  end

end
