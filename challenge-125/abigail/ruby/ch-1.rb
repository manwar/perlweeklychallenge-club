#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

def introot (square)
    return Math . sqrt(square) . floor()
end

ARGF . each_line do
    |n|
    n = n . to_i
    if (n <= 2) then
        puts (-1)
    end

    n_sq = n * n
    c    = n + 1
    c_sq = n_sq + 2 * n + 1
    while (2 * c - 1 <= n_sq) do
        b_sq = c_sq - n_sq
        b    = introot (b_sq)

        if (b_sq == b * b) then
            puts (n . to_s + " " + b . to_s + " " + c . to_s)
        end

        c_sq += 2 * c + 1
        c    += 1
    end

    max_a = (n / Math . sqrt(2)) . floor()
    for a in 3 .. max_a do
        b_sq = n_sq - a * a
        b    = introot (b_sq)
        if (b_sq == b * b) then
            puts (a . to_s + " " + b . to_s + " " + n . to_s)
        end
    end
end
