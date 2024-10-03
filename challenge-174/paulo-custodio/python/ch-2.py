#!/usr/bin/env python3

# Challenge 174
#
# Task 2: Permutation Ranking
# Submitted by: Mohammad S Anwar
#
# You are given a list of integers with no duplicates, e.g. [0, 1, 2].
#
# Write two functions, permutation2rank() which will take the list and determine
# its rank (starting at 0) in the set of possible permutations arranged in
# lexicographic order, and rank2permutation() which will take the list and a rank
# number and produce just that permutation.
#
# Please checkout this post for more informations and algorithm.
#
# Given the list [0, 1, 2] the ordered permutations are:
#
# 0: [0, 1, 2]
# 1: [0, 2, 1]
# 2: [1, 0, 2]
# 3: [1, 2, 0]
# 4: [2, 0, 1]
# 5: [2, 1, 0]
#
# and therefore:
#
# permutation2rank([1, 0, 2]) = 2
#
# rank2permutation([0, 1, 2], 1) = [0, 2, 1]

from math import factorial

def fact(n):
    return factorial(n)

def permutation2rank(p):
    n = len(p)
    fact_n_minus_1 = fact(n - 1)  # (n-1)!
    rank = 0
    digits = list(range(n))  # all unused digits
    for i in range(n - 1):
        q = next(index for index, value in enumerate(digits) if value == p[i])
        rank += fact_n_minus_1 * q
        digits.pop(q)  # remove digit p[i]
        fact_n_minus_1 //= (n - 1 - i)  # weight of next digit
    return rank

def rank2permutation(p, rank):
    n = len(p)
    fact_n_minus_1 = fact(n - 1)  # (n-1)!
    digits = list(range(n))  # all unused digits
    result = []
    for i in range(n):
        q = rank // fact_n_minus_1  # by decomposing rank = q * fact + rest
        rank %= fact_n_minus_1
        result.append(digits[q])
        digits.pop(q)  # remove digit at position q
        if i != n - 1:
            fact_n_minus_1 //= (n - 1 - i)  # weight of next digit
    return result

# Testing
print("ok 1" if permutation2rank([1, 0, 2]) == 2 else "nok 1")
print("ok 2" if rank2permutation([0, 1, 2], 1) == [0, 2, 1] else "nok 2")
print("1..2")
