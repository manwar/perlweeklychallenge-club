#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    |n|
    result = 0
    seen_one = false
    n . scan(/[0-9]/) do
        |digit|
        result *= 9
        if (seen_one)
            result += 8
        elsif (digit == "1")
            seen_one = true
        elsif (digit != "0")
            result += digit . to_i - 1
        end
    end
    puts (result)
end
