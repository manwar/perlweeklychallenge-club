#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb
#

$base = 10
count =  5

def is_long (number)
    seen = Array . new(number, 0)
    rest = 0
    for _ in 2 .. number do
        rest = (rest * $base + $base - 1) % number
        if seen [rest] == 1 then
            return false
        end
        seen [rest] = 1
    end
    return true
end


number = 1
while count > 0 do
    number += 1
    if $base % number == 0 then
        next
    end
    if is_long (number) then
        puts (number)
        count -= 1
    end
end
