#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

nr_of_digits = 10

ARGF . each_line do
    |line|
    #
    # Read the input and count the digits
    #
    digits = []
    for d in 0 .. nr_of_digits - 1 do
        digits [d] = 0
    end
    line . split() . each do
        |d|
        digits [d . to_i] += 1
    end

    #
    # Find the lowest even number
    #
    last = -1
    for i in 1 .. nr_of_digits do
        d = nr_of_digits - i
        if   d % 2 == 0 && digits [d] > 0
        then last = d
        end
    end

    #
    # Skip if the input does not contain an even number
    #
    if   last < 0
    then next
    end

    digits [last] -= 1

    #
    # Print the digits, highest to lowest
    #
    for i in 1 .. nr_of_digits do
        d = nr_of_digits - i
        for j in 1 .. digits [d] do
            print (d)
        end
    end
    puts (last)
end
