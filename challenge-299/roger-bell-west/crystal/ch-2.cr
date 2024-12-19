#! /usr/bin/crystal

def encode(x, y)
    x * 64 + y
end

def decode(z)
  z.divmod(64)
end

def wordsearch(grid0, word0)
  grid = Hash(Int32, Char).new
  grid0.each_with_index do |row, y|
    row.each_with_index do |c, x|
      grid[encode(x, y)] = c
    end
  end
  word = word0.chars
  grid.each do |start, firstletter|
    if firstletter == word[0]
      queue = Deque(Array(Int32)).new
      queue.push([start])
      while queue.size > 0
        pos = queue.shift
        if pos.size == word.size
          return true
        else
          [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |dir|
            lpos = decode(pos[-1])
            npos = [lpos[0] + dir[0], lpos[1] + dir[1]] 
            np = encode(npos[0], npos[1])
            posmap = Set.new(pos)
            if grid.has_key?(np) &&
               !posmap.includes?(np) &&
               grid[np] == word[pos.size]
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

require "spec"
describe "wordsearch" do
  it "test_ex1" do
    wordsearch([['A', 'B', 'D', 'E'], ['C', 'B', 'C', 'A'], ['B', 'A', 'A', 'D'], ['D', 'B', 'B', 'C']], "BDCA").should eq true
  end
  it "test_ex2" do
    wordsearch([['A', 'A', 'B', 'B'], ['C', 'C', 'B', 'A'], ['C', 'A', 'A', 'A'], ['B', 'B', 'B', 'B']], "ABAC").should eq false
  end
  it "test_ex3" do
    wordsearch([['B', 'A', 'B', 'A'], ['C', 'C', 'C', 'C'], ['A', 'B', 'A', 'B'], ['B', 'B', 'A', 'A']], "CCCAA").should eq true
  end
end
