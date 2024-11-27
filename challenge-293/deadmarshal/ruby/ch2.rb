#!/usr/bin/env ruby

def boomerang(a)
  (a[1][1] - a[0][1]) * (a[2][0] - a[1][0]) !=
    (a[2][1] - a[1][1]) * (a[1][0] - a[0][0])
end

puts boomerang([[1,1],[2,3],[3,2]])
puts boomerang([[1,1],[2,2],[3,3]])
puts boomerang([[1,1],[1,2],[2,3]])
puts boomerang([[1,1],[1,2],[1,3]])
puts boomerang([[1,1],[2,1],[3,1]])
puts boomerang([[0,0],[2,3],[4,5]])

