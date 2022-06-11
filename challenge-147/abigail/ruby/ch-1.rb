#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#
 
#
# Run as: ruby ch-1.rb
#

require 'prime'

todo = [2, 3, 5, 7];

todo . each do
    | x |
    print (x . to_s + " ")
end

count = 20 - todo . length

pow = 10
while todo . length > 0 && count > 0 do
    new_todo = []
    for d in 1 .. 9 do
        todo . each do
            | p |
            candidate = d * pow + p
            if (Prime . prime? (candidate)) then
                new_todo . push (candidate)
                print (candidate . to_s + " ")
                count = count - 1
                if (count <= 0) then
                    break
                end
            end
            if (count <= 0) then
                break
            end
        end
        if (count <= 0) then
            break
        end
    end
    pow = pow * 10
    todo = new_todo
end

puts ("")
