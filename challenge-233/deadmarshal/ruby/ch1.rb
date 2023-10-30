#!/usr/bin/env ruby

def similar_words(arr)
  count,h = 0,Hash.new(0)
  arr.each{|s| h[s.split('').sort.uniq.join] += 1}
  h.values.each{|v| count += (v * (v-1)) / 2}
  count
end

p similar_words(["aba","aabb","abcd","bac","aabc"])
p similar_words(["aabb","ab","ba"])
p similar_words(["nba","cba","dba"])

