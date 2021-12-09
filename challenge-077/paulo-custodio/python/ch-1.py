#!/usr/bin/python3

# Challenge 077
#
# TASK #1 > Fibonacci Sum
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# UPDATE: 2020-09-07 09:00:00
# Write a script to find out all possible combination of Fibonacci Numbers
# required to get $N on addition.
#
# You are NOT allowed to repeat a number. Print 0 if none found.
#
# Example 1:
# Input: $N = 6
#
# Output:
#     1 + 2 + 3 = 6
#     1 + 5 = 6
# Example 2:
# Input: $N = 9
#
# Output:
#     1 + 8 = 9
#     1 + 3 + 5 = 9

import sys
from itertools import combinations

# compute list of Fibonacci numbers up to input
fib = [0, 1]

def compute_fib(target):
    global fib
    while fib[-1] < target:
        fib.append(fib[-1]+fib[-2])

N = int(sys.argv[1])
compute_fib(N)

# terms for addition are the Fibonacci numbers except the first two terms (0,1)
terms = fib[2:]
output = []
for k in range(1, len(terms)+1):
    for combin in combinations(terms, k):
        if sum(combin)==N:
            combin = sorted(list(combin))
            output.append(" + ".join([str(x) for x in combin])+" = "+str(N))
output.sort()
print(*output,sep="\n")
