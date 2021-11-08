#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

$cache = {}

def _count (target, this_fib, prev_fib)
    key = target . to_s + ";" + this_fib . to_s
    $cache [key] ||= target <  this_fib ? 0
                   : target == this_fib ? 1
                   : _count(target - this_fib, this_fib + prev_fib, this_fib) +
                     _count(target,            this_fib + prev_fib, this_fib)
    return $cache [key]
end

def count (target)
    return _count(target, 1, 1)
end

ARGF . each_line do
    | line |
    puts (count(line . to_i))
end
