#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb
#

$small_primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]

def factorize (num)
    factors = []
    $small_primes . each do 
        | prime |
        while num % prime == 0 do
            factors . push(prime)
            num /= prime
        end
    end
    if num > 1 then
        factors . push (num)
    end
    return (factors)
end


def digit_sum (numbers)
    sum = 0
    numbers . each do
        | num |
        while num > 0 do
            sum += num % 10
            num /= 10
        end
    end
    return sum
end


number = 1
count  = 0

while count < 10 do
    factors = factorize(number)
    if factors . length > 1 and digit_sum([number]) == digit_sum(factors) then
        puts (number)
        count += 1
    end
    number += 1
end

