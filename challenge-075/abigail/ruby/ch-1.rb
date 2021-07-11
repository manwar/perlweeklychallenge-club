#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

def possibilities (target, coins)
    return 1 if target == 0
    return 0 if target <  0 || coins . length == 0

    sum = 0
    for i in 0 .. (target / coins [0]) . to_i do
        sum += possibilities(target - i * coins [0], coins [1 .. -1])
    end

    return sum
end

ARGF . each_line do
    |line|
    coins = line . split . map do
        |c|
        c . to_i
    end

    target = coins . shift

    puts (possibilities(target, coins))
end
