#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

def can_split (target, number)
    if target >  number || target < 0 then
        return false
    end
    if target == number then
        return true
    end

    pow_10 = 10

    while pow_10 <= number do
        if can_split(target - (number % pow_10), number / pow_10) then
            return true
        end
        pow_10 *= 10
    end

    return false
end

ARGF . each_line do
    | number |
    number = number . to_i
    if number > 1 && can_split((Math . sqrt(number)) . to_i, number) then
        puts (1)
    else
        puts (0)
    end
end
