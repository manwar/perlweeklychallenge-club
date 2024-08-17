#! /usr/bin/ruby

require 'set'

def cs2xy(a)
  c = a.chars
  x = c[0].ord - 'a'.ord
  y = c[1].ord - '1'.ord
  [x, y]
end

def knightsmove(from, to)
  fc = cs2xy(from)
  tc = cs2xy(to)
  queue = Array.new
  queue.push([fc[0], fc[1], 0])
  seen = Set.new
  while queue.size > 0
    cc = queue.shift
    if cc[0] == tc[0] && cc[1] == tc[1]
      return cc[2]
    else
      [
        [2, 1],
        [1, 2],
        [2, -1],
        [1, -2],
        [-2, 1],
        [-1, 2],
        [-2, -1],
        [-1, -2],
      ].each do |offset|
        x = cc[0] + offset[0]
        y = cc[1] + offset[1]
        if x >= 0 && x <= 7 && y >= 0 && y <= 7
          if !seen.include?([x, y])
            queue.push([x, y, cc[2] + 1])
            seen.add([x, y])
          end
        end
      end
    end
  end
  -1
end

require 'test/unit'

class TestKnightsmove < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, knightsmove('g2', 'a8'))
  end

  def test_ex2
    assert_equal(3, knightsmove('g2', 'h2'))
  end

end
