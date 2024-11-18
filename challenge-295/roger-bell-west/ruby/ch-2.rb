#! /usr/bin/ruby

require 'set'

def jumpgame(a)
  target = a.length - 1
  moves = 0
  here = Set.new([0])
  while true do
    moves += 1
    there = Set.new
    here.each do |n|
      (n+1).upto([n + a[n], target].min).each do |i|
        there.add(i)
      end
    end
    if there.size == 0
      return -1
    end
    if there.include?(target)
      return moves
    end
    here = there
  end
end

require 'test/unit'

class TestJumpgame < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, jumpgame([2, 3, 1, 1, 4]))
  end

  def test_ex2
    assert_equal(2, jumpgame([2, 3, 0, 4]))
  end

  def test_ex3
    assert_equal(-1, jumpgame([2, 0, 0, 4]))
  end

end
