#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

n = gets . to_i

scores = [[], [], [""]]

for i in 1 .. n do
    new = []
    for j in 1 .. 3 do
        for k in scores [-j] do
            new . push (j . to_s + " " + k)
        end
    end
    scores . push (new)
end

for score in scores [-1] do
    puts (score)
end
