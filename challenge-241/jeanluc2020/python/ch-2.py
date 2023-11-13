#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-241/#TASK2
#
# Task 2: Prime Order
# ===================
#
# You are given an array of unique positive integers greater than 2.
#
# Write a script to sort them in ascending order of the count of their prime
# factors, tie-breaking by ascending value.
#
## Example 1
##
## Input: @int = (11, 8, 27, 4)
## Output: (11, 4, 8, 27))
##
## Prime factors of 11 => 11
## Prime factors of  4 => 2, 2
## Prime factors of  8 => 2, 2, 2
## Prime factors of 27 => 3, 3, 3
#
############################################################
##
## discussion
##
############################################################
#
# Sort by number of prime factors first, then by the number
# itself second.
# We calculate the number of prime factors in an extra recursive
# function, using a cache of already calculated numbers to mitigate
# unnecessary recalculations
#

from operator import itemgetter

def prime_factor_count(number: int) -> int:
    cache = {}
    def prime_factor_count_interal(num: int) -> int:
        count = 0
        if num not in cache.keys():
            for i in range(2, num+1):
                if num % i == 0:
                    count = 1 + prime_factor_count_interal(int(num / i))
                    break
            cache[num] = count
        return cache[num]
    return prime_factor_count_interal(number)


def prime_order(nums: list):
    print("Input: (", ", ".join(str(x) for x in nums), ")", sep='')
    decorated = [ (prime_factor_count(x), x) for x in nums ]
    decorated_result = sorted(decorated, key=lambda x: (x[0], x[1]))
    result = [ x[1] for x in decorated_result ]
    print("Output: (", ", ".join(str(x) for x in result), ")", sep='')


prime_order([11, 8, 27, 4])
prime_order([11, 27, 8, 4])

