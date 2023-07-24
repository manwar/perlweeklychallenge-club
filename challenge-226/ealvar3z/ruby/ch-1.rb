#!/usr/bin/env ruby

def main(s, indices)
  raise "Error: the strings are not matching in length" unless s.length == indices.length
  hash = indices.zip(s.chars).to_h

  result = hash.sort_by {|k, v| k}.map {|v| v[1]}
  result.join
end

str = 'lacelengh'
idxs = %w(3 2 0 5 4 8 6 7 1)

puts main(str, idxs)

