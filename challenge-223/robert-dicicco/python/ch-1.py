#!/usr/bin/env python
# -----------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-06-26
# Challenge 223 Task 1 Count Primes ( Python )
# -----------------------------------------

input_n = [10,1,20]

def isprime(num):
    if num > 1:
        for n in range(2,num):
            if (num % n) == 0:
                return False
        return True
    else:
        return False

for n in input_n :
    print(f"Input: $n = {n}")
    num = 0
    cnt = 0
    while num < n :
        if isprime(num):
            #print(num)
            cnt += 1
        num += 1
    print(f"Output: {cnt}\n")

# -----------------------------------------
# SAMPLE OUTPUT
# python .\CountPrimes.py
# Input: $n = 10
# Output: 4
# #
# Input: $n = 1
# Output: 0
# #
# Input: $n = 20
# Output: 8
# -----------------------------------------


