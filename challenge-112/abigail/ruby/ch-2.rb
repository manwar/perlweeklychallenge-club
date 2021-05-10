#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

$cache = {}
$cache [0] = 1
$cache [1] = 1

def fib (n)
    $cache [n] ||= fib(n - 1) + fib(n - 2)
end

ARGF . each_line do
    | n |
    puts (fib(n . to_i))
end
