#! /usr/bin/ruby

require "set"

def encode(x, y)
    x * 64 + y
end

def decode(z)
  z.divmod(64)
end

def wordsearch(grid0, word0)
  grid = Hash.new
  grid0.each_with_index do |row, y|
    row.each_with_index do |c, x|
      grid[encode(x, y)] = c
    end
  end
  word = word0.chars
  grid.each do |start, firstletter|
    if firstletter == word[0]
      queue = [[start]]
      while queue.length > 0
        pos = queue.shift
        if pos.length == word.length
          return true
        else
          [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |dir|
            lpos = decode(pos[-1])
            npos = [lpos[0] + dir[0], lpos[1] + dir[1]] 
            np = encode(npos[0], npos[1])
            posmap = Set.new(pos)
            if grid.include?(np) &&
               posmap.find_index(np) == nil &&
               grid[np] == word[pos.length]
              pp = pos.clone
              pp.push(np)
              queue.push(pp)
            end
          end
        end
      end
    end
  end
  false
end

require 'test/unit'

class TestWordsearch < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, wordsearch([['A', 'B', 'D', 'E'], ['C', 'B', 'C', 'A'], ['B', 'A', 'A', 'D'], ['D', 'B', 'B', 'C']], 'BDCA'))
  end

  def test_ex2
    assert_equal(false, wordsearch([['A', 'A', 'B', 'B'], ['C', 'C', 'B', 'A'], ['C', 'A', 'A', 'A'], ['B', 'B', 'B', 'B']], 'ABAC'))
  end

  def test_ex3
    assert_equal(true, wordsearch([['B', 'A', 'B', 'A'], ['C', 'C', 'C', 'C'], ['A', 'B', 'A', 'B'], ['B', 'B', 'A', 'A']], 'CCCAA'))
  end

end
