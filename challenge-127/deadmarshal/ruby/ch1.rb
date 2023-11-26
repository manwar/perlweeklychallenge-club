#!/usr/bin/env ruby

def disjoint_sets(s1,s2)
  h = Hash.new(0)
  (0...s1.length).each do |i|
    h[s1[i]] += 1
    h[s2[i]] += 1
  end
  h.values.all? {|e| e == 1}
end

p disjoint_sets([1,2,5,3,4],[4,6,7,8,9])
p disjoint_sets([1,3,5,7,9],[0,2,4,6,8])

