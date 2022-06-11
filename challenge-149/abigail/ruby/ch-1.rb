#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
#
 
#
# Run as: ruby ch-1.rb < input-file
#

def digit_sum (number)
    sum  =  0
    base = 10
    while number > 0 do
        sum    += number % base
        number /= base
    end
    return sum
end

$fib            = {}
$fib_prev       = 0
$fib_last       = 1
$fib[$fib_prev] = true
$fib[$fib_last] = true

def is_fib (n)
    while $fib_last < n do
        t               = $fib_last
        $fib_last      += $fib_prev
        $fib_prev       = t
        $fib[$fib_last] = true
    end

    return $fib[n]
end

ARGF . each_line do |n|
    n = n . to_i
    k = 0
    while n > 0 do
        if is_fib(digit_sum(k)) then
            printf "%d ", k
            n -= 1
        end
        k += 1
    end
    puts ("")
end
