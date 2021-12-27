#!/usr/bin/python3

# Challenge 076
#
# TASK #1 > Prime Sum
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
# You are given a number $N. Write a script to find the minimum number of
# prime numbers required, whose summation gives you $N.
#
# For the sake of this task, please assume 1 is not a prime number.
#
# Example:
# Input:
#     $N = 9
#
# Ouput:
#     2 as sum of 2 prime numbers i.e. 2 and 7 is same as the input number.
#     2 + 7 = 9.

import sys
from primePy import primes
from itertools import combinations

def next_prime(n):
    if n <= 1:
        return 2
    else:
        n += 1
        while not primes.check(n):
            n += 1
        return n

# check all combinations for the shortest that adds up to N
def find_set(n):
    # get all primes up to N, 1 not included;
    # append primes 2 and 3 to be able to solve special cases 4 and 6
    terms = primes.upto(n)
    terms.extend([2, 3])

    solution = []
    for k in range(1, len(terms)+1):
        for combin in combinations(terms, k):
            if sum(combin)==n:
                if len(solution)==0 or len(solution)>len(combin):
                    solution = sorted(list(combin))
                    if len(solution)==1:
                        return solution     # special case - is prime
    return solution

n = int(sys.argv[1])
solution = find_set(n)
print(" + ".join([str(x) for x in solution])+" = "+str(n))
