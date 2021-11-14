#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

def reverse (num)    
    rev = 0
    while num > 0 do
        rev *= 10
        rev += num % 10
        num /= 10
    end
    return rev
end

def ly (num)
    return num >= 10000000      ? 1
         : num == reverse(num) ? 0
         : ly(num + reverse(num))
end

ARGF . each_line do
    | number |
    puts (ly(number . to_i))
end
