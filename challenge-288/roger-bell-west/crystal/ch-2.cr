#! /usr/bin/crystal

def contiguousblock(a)
  y = a.size
  x = a[0].size
  starts = Set(Array(Int32)).new
  0.upto(x - 1) do |cx|
    0.upto(y - 1) do |cy|
      starts.add([cx, cy])
    end
  end
  maxblock = 0
  while starts.size > 0
    start = starts.to_a[0]
    queue = Array(Array(Int32)).new
    visited = Set(Array(Int32)).new
    visited.add(start)
    queue.push(start)
    while queue.size > 0
      here = queue.shift
      [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |delta|
        if (delta[0] >= 0 || here[0] > 0) &&
           (delta[0] <= 0 || here[0] < x - 1) &&
           (delta[1] >= 0 || here[1] > 0) &&
           (delta[1] <= 0 || here[1] < y - 1)
          there = [here[0] + delta[0], here[1] + delta[1]]
          if (!visited.includes?(there) &&
              a[there[1]][there[0]] == a[start[1]][start[0]])
            visited.add(there)
            queue.push(there)
          end
        end
      end
    end
    sz = visited.size
    if (sz > maxblock)
      maxblock = sz
    end
    starts -= visited
  end
  return maxblock
end

require "spec"
describe "contiguousblock" do
  it "test_ex1" do
    contiguousblock([["x", "x", "x", "x", "o"], ["x", "o", "o", "o", "o"], ["x", "o", "o", "o", "o"], ["x", "x", "x", "o", "o"]]).should eq 11
  end
  it "test_ex2" do
    contiguousblock([["x", "x", "x", "x", "x"], ["x", "o", "o", "o", "o"], ["x", "x", "x", "x", "o"], ["x", "o", "o", "o", "o"]]).should eq 11
  end
  it "test_ex3" do
    contiguousblock([["x", "x", "x", "o", "o"], ["o", "o", "o", "x", "x"], ["o", "x", "x", "o", "o"], ["o", "o", "o", "x", "x"]]).should eq 7
  end
end
