#! /usr/bin/ruby

candidates = Array.new(49) {|i| i + 1}
candidates.shuffle!
candidates = candidates[0..5]
candidates.sort!
print("#{candidates}\n")
