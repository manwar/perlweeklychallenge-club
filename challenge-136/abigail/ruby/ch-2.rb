#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

def count (target, this_fib, prev_fib)
    return target <  this_fib ? 0
         : target == this_fib ? 1
         : count(target - this_fib, this_fib + prev_fib, this_fib) +
           count(target,            this_fib + prev_fib, this_fib)
end

ARGF . each_line do
    | line |
    puts (count(line . to_i, 1, 1))
end
