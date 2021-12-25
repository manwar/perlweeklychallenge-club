#!/usr/bin/python3

# Challenge 144
#
# TASK #1 > Semiprime
# Submitted by: Mohammad S Anwar
# Write a script to generate all Semiprime number <= 100.
#
# For more information about Semiprime, please checkout the wikipedia page.
#
#
# In mathematics, a semiprime is a natural number that is the product of
# exactly two prime numbers. The two primes in the product may equal each
# other, so the semiprimes include the squares of prime numbers.
#
#
# Example
# 10 is Semiprime as 10 = 2 x 5
# 15 is Semiprime as 15 = 3 x 5

import sys
from primePy import primes

MAX_NUM = 100

# list of primes up to max/smallest_prime
prime_nums = primes.upto(MAX_NUM/2)

# set of all semiprimes
semiprime_set = set()
for i in range(len(prime_nums)):
    for j in range(len(prime_nums)):
        n = prime_nums[i]*prime_nums[j]
        semiprime_set.add(n)

# sort and filter <= MAX_NUM
semiprimes = sorted(filter(lambda x:x <= MAX_NUM, list(semiprime_set)))

print(*semiprimes, sep=", ")
